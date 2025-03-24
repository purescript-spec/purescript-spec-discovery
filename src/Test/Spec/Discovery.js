import path from "path";
import fs from "fs";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const __onWindows =
  process.platform === "win32" || process.platform === "win64";

if (import.meta.url === `file://${process.argv[1]}`) {
  throw new Error(
    "Sorry, purescript-spec-discovery only supports NodeJS environments!",
  );
}

export function getSpecs(pattern, mapToAff) {
  return (onError, onSuccess) => {
    const regex = new RegExp(pattern);
    const modulePromises = fs
      .readdirSync(path.join(__dirname, ".."))
      .filter((directory) => regex.test(directory))
      .map((name) => {
        const fullPath = __onWindows
          ? path.join("file://", __dirname, "..", name, "index.js")
          : path.join(__dirname, "..", name, "index.js");
        return import(fullPath).then((module) => {
          let spec =
            module && typeof module.spec !== "undefined" ? module.spec : null;

          if (!spec) return spec;

          if (spec.constructor.name !== "Aff") {
            return mapToAff(spec);
          }

          return spec;
        });
      });

    Promise.all(modulePromises)
      .then((specs) => {
        const s = specs.filter((x) => x);
        return onSuccess(s);
      })
      .catch(onError);

    return () => {};
  };
}
