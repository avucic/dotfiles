module.exports = {
  env: {
    es6: true,
    browser: true,
    node: true,
    mocha: true,
    jquery: true,
    jest: true
  },
  globals: {
    Atomics: 'readonly',
    SharedArrayBuffer: 'readonly',
  },
  parserOptions: {
    ecmaVersion: 2018,
    sourceType: 'module',
    parser: 'babel-eslint',
  },
  extends: [
    'airbnb-base',
    'plugin:vue/recommended',
    // 'plugin:prettier/recommended',
  ],
  plugins: [
    // 'html',
    // 'prettier',
    // 'vue',
    'prefer-object-spread'
  ],
  rules: {
    'no-new': 0,
    'prefer-object-spread/prefer-object-spread': 2,
    semi: [2, "never"],
    curly: ["error", "all"],
    'no-console': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-param-reassign': ["error", {
      'ignorePropertyModificationsFor': ["res", "ctx"]
    }],
    'import/no-unresolved': 0,
    'import/no-extraneous-dependencies': ["error", {
      "devDependencies": true
    }],
    'no-multiple-empty-lines': [
      2,
      {
        max: 2,
        maxEOF: 0,
        maxBOF: 0
      }
    ],
    'no-unused-vars': [
      1,
      {
        argsIgnorePattern: "res|next|^err"
      }
    ],
    'import/extensions': ["error", "never", {
      packages: "always",
      gql:'ignorePackages'
    }],
    'object-curly-newline': ["error", {
      multiline: true,
      minProperties: 3,
      consistent: true
    }],
    'no-underscore-dangle': ["error", {
      allow: ["__user__", "_id", "__typename", "__ob__"]
    }],
    'no-unused-expressions': ["error",
      {
        allowTernary: true
      }
    ],
    // 'prettier/prettier': ["error", {
    //   semi: false,
    //   singleQuote: true,
    //   tabWidth: 2
    // }],
    // 'vue/max-attributes-per-line': "off"
    // 'vue/max-attributes-per-line': ['error', {
    //   singleline: 10,
    //   multiline: {
    //     max: 2,
    //     allowFirstLine: false,
    //   }
    // }],
    // "vue/html-indent": ["error", 2, {
    //   "attribute": 1,
    //   "closeBracket": 0,
    //   "alignAttributesVertically": true,
    //   "ignores": []
    // }]
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: [".js", ".vue"]
      }
    }
  }

}
