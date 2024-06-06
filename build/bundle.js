import { bundle } from "luabundle";
import * as fs from "fs";

// Config
const config = {
    inputFile: "../src/Main.lua",
    outputFile: "./out/LmaoLib.lua",
};

// Bundle the library
const bundledLua = bundle(config.inputFile, {
    metadata: false,
    paths: ["../?.lua"],

    expressionHandler: (module, expression) => {
        const start = expression.loc.start;
        console.warn(`⚠️ Non-literal require found in '${module.name}' at ${start.line}:${start.column}`);
    },
});

// Write the output to a file
fs.writeFile(config.outputFile, bundledLua, (err) => {
    if (err) {
        console.error(`❌ ${err.message}`);
        return;
    }

    console.log(`✅ Library bundle created at ${config.outputFile}`);
});
