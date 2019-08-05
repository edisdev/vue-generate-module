# vue-generate-module

You need to specify in your app general path of pages and components. . You can this to <strong> create-module-config.json </strong> file.

 ### create-module-config.son
 
``` html
  {
    "pagePath": Directory path of all general pages located in your app. (for example: src/pages),
    "componentPath": Directory path of all components located in your app. (for example: src/components),
    "storePath": Directory path of stores located in your app. for example. ( src/stores)
  }
```

After editing the create-module-config.json file, you can run with the script code `(create-module script)` in the package.json file. When doing this, you should add module name to end of script. (  yarn create-module Home etc. / Home is pages / component name & "--ignoreStore": You can to specify want to using store when creating page (default: false, yarn create-module Home --ignoreStore)

Just , that's it :)
