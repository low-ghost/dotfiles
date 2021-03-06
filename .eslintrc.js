'use strict';
module.exports = {
  'env': {
    'node': true,
    'mocha': true,
    'es6': true,
    'browser': true,
  },
  settings: {
    'ecmascript': 7,
    'import/parser': 'babel-eslint',
    'import/resolve': {
        moduleDirectory: [ 'node_modules', 'src' ],
    },
  },
  parser: 'babel-eslint',
  parserOptions: {
    ecmaVersion: 6,
    ecmaFeatures: {
      modules: true,
      experimentalObjectRestSpread: true,
      blockBindings: true,
      jsx: true,
    },
    sourceType: 'module',
  },
  'rules': {
    'accessor-pairs': 'off',
    'array-callback-return': 'error',
    'block-scoped-var': 'error',
    'complexity': [ 'warn', 11 ],
    'consistent-return': 'error',
    'curly': [ 'error', 'multi-or-nest', 'consistent' ],
    'default-case': 'error',
    'dot-notation': [ 'error', { 'allowKeywords': true } ],
    'dot-location': [ 'error', 'property' ],
    'eqeqeq': 'error',
    'guard-for-in': 'off',
    // TEMPORARY
    'id-blacklist': [ 'error' ],
    'no-alert': 'error',
    'no-caller': 'error',
    'no-case-declarations': 'error',
    'no-div-regex': 'error',
    'no-else-return': 'error',
    'no-extra-label': 'error',
    'no-eq-null': 'warn',
    'no-eval': 'error',
    'no-extend-native': 'error',
    'no-extra-bind': 'error',
    'no-fallthrough': 'error',
    'no-floating-decimal': 'error',
    'no-implicit-coercion': 'error',
    'no-implied-eval': 'error',
    // Too many false flags
    'no-invalid-this': 'off',
    'no-iterator': 'error',
    'no-labels': [ 'error', { 'allowLoop': false, 'allowSwitch': false } ],
    'no-lone-blocks': 'error',
    'no-loop-func': 'error',
    'no-multi-spaces': 'off',
    'no-multi-str': 'error',
    'no-native-reassign': 'error',
    'no-new': 'error',
    'no-new-func': 'error',
    'no-new-wrappers': 'error',
    'no-octal': 'error',
    'no-param-reassign': [ 'error', { 'props': true } ],
    'no-process-env': 'error',
    'no-proto': 'error',
    'no-redeclare': 'error',
    'no-return-assign': 'error',
    'no-script-url': 'error',
    'no-self-compare': 'error',
    'no-sequences': 'error',
    'no-throw-literal': 'error',
    'no-unmodified-loop-condition': 'off',
    'no-unused-expressions': 'error',
    'no-unused-labels': 'error',
    'no-useless-call': 'error',
    'no-void': 'error',
    'no-warn-comments': [
      'off',
      {
        'terms': [
          'todo',
          'fixme',
          'xxx',
        ],
        'location': 'start',
      },
    ],
    'no-with': 'error',
    'radix': 'off',
    'vars-on-top': 'error',
    'wrap-iife': [ 'error', 'outside' ],
    'yoda': 'error',
    'no-cond-assign': [ 'error', 'always' ],
    'no-console': 'off',
    'no-constant-condition': 'off',
    'no-control-regex': 'error',
    'no-debugger': 'warn',
    'no-dupe-args': 'error',
    'no-dupe-keys': 'error',
    'no-duplicate-case': 'error',
    'no-empty-character-class': 'error',
    'no-empty': 'error',
    'no-ex-assign': 'error',
    'no-extra-boolean-cast': 'off',
    'no-extra-semi': 'error',
    'no-func-assign': 'error',
    'no-inner-declarations': 'error',
    'no-invalid-regexp': 'error',
    'no-negated-in-lhs': 'error',
    'no-obj-calls': 'error',
    'no-regex-spaces': 'error',
    'no-sparse-arrays': 'error',
    'no-unreachable': 'error',
    'use-isnan': 'error',
    'require-jsdoc': 'error',
    'valid-jsdoc': 'error',
    'valid-typeof': 'error',
    'no-unexpected-multiline': 'error',
    'comma-dangle': [ 'error', 'always-multiline' ],
    'max-depth': [ 'warn', 6 ],
    'max-params': [ 'error', 8 ],
    'max-statements': [ 'warn', 10 ],
    'no-bitwise': 'off',
    'no-plusplus': 'off',
    'callback-return': 'warn',
    'newline-before-return': 'off',
    'handle-callback-err': 'warn',
    'no-mixed-requires': [ 'off', false ],
    'no-new-require': 'error',
    'no-path-concat': 'off',
    'no-process-exit': 'off',
    'no-restricted-modules': 'off',
    'no-sync': 'off',
    'array-bracket-spacing': [ 'error', 'always' ],
    'brace-style': [ 'error', '1tbs' ],
    'camelcase': [ 'error', { 'properties': 'never' } ],
    'comma-spacing': [ 'error', { 'before': false, 'after': true } ],
    'comma-style': [ 'error', 'last' ],
    'computed-property-spacing': [ 'error', 'never' ],
    'consistent-this': [ 'error', 'self' ],
    'eol-last': 'error',
    'func-names': 'off',
    'func-style': [ 'error', 'expression' ],
    'id-length': [
      'error',
      {
        'min': 3,
        'exceptions': [
          'as',
          'in',
          '$',
          '_',
          'io',
          'x',
          'y',
          'id',
          'e',
          'to',
          'fs',
          'fn',
          'ex',
          'p',
          'ps',
          'of',
          'ws',
          'cb',
        ],
      },
    ],
    'indent': [ 'error', 2, { 'SwitchCase': 1 } ],
    'jsx-quotes': [ 'error', 'prefer-double' ],
    'key-spacing': [ 'error', { 'beforeColon': false, 'afterColon': true } ],
    'keyword-spacing': [
      'error',
      {
        'before': true,
        'after': true,
        'overrides': {
          'return': {
            'after': true,
          },
          'throw': {
            'after': true,
          },
          'case': {
            'after': true,
          },
        },
      },
    ],
    'lines-around-comment': 'off',
    'linebreak-style': [ 'error', 'unix' ],
    'max-len': [
      'error',
      100,
      2,
      {
        'ignoreUrls': true,
        'ignoreComments': false,
      },
    ],
    'max-nested-callbacks': 'off',
    'new-cap': [ 'error', { 'newIsCap': true } ],
    'new-parens': 'off',
    'newline-after-var': 'error',
    'newline-per-chained-call': [ 'error', { 'ignoreChainWithDepth': 5 } ],
    'no-array-constructor': 'error',
    'no-continue': 'off',
    'no-inline-comments': 'off',
    'no-lonely-if': 'error',
    'no-mixed-spaces-and-tabs': 'error',
    'no-multiple-empty-lines': [ 'error', { 'max': 2, 'maxEOF': 1 } ],
    'no-nested-ternary': 'error',
    'no-new-object': 'error',
    'no-spaced-func': 'error',
    'no-ternary': 'off',
    'no-trailing-spaces': 'error',
    'no-underscore-dangle': 'off',
    'no-unneeded-ternary': [ 'error', { 'defaultAssignment': false } ],
    'no-whitespace-before-property': 'error',
    'object-curly-spacing': [ 'error', 'always' ],
    'one-var': [ 'error', 'never' ],
    'one-var-declaration-per-line': [ 'error', 'always' ],
    'operator-assignment': 'off',
    'operator-linebreak': 'off',
    'padded-blocks': [ 'error', 'always' ],
    'quote-props': [ 'error', 'as-needed' ],
    'id-match': 'off',
    'semi-spacing': [ 'error', { 'before': false, 'after': true } ],
    'semi': [ 'error', 'always' ],
    'sort-vars': 'off',
    'space-before-blocks': 'error',
    'space-before-function-paren': [ 'error', { 'anonymous': 'always', 'named': 'never' } ],
    'space-in-parens': [ 'error', 'never' ],
    'space-infix-ops': 'error',
    'space-unary-ops': [ 'error', { 'words': true, 'nonwords': false } ],
    'spaced-comment': [ 'off' ],
    'wrap-regex': 'off',
    'init-declarations': 'off',
    'no-catch-shadow': 'error',
    'no-delete-var': 'error',
    'no-implicit-globals': 'off',
    'no-label-var': 'error',
    'no-self-assign': 'error',
    'no-shadow-restricted-names': 'error',
    'no-shadow': 'error',
    'no-undef-init': 'off',
    'no-undef': 'error',
    'no-undefined': 'off',
    'no-unused-vars': [
      'error',
      {
        'args': 'after-used',
        'argsIgnorePattern': '^e$|^__$',
        'varsIgnorePattern': '^(I([A-Z].*|nterface|)|Q|^__$)$|^React$',
      },
    ],
    'no-use-before-define': 'off',
    'arrow-body-style': [ 'off', 'as-needed' ],
    'arrow-parens': [ 'error', 'always' ],
    'arrow-spacing': [ 'error', { 'before': true, 'after': true } ],
    'constructor-super': 'off',
    'generator-star-spacing': 'off',
    'no-class-assign': 'off',
    'no-confusing-arrow': 'off',
    'no-const-assign': 'error',
    'no-new-symbol': 'error',
    'no-restricted-imports': 'off',
    'no-this-before-super': 'error',
    'no-var': 'error',
    'no-useless-constructor': 'error',
    'object-shorthand': [ 'error', 'always' ],
    'prefer-arrow-callback': 'error',
    'prefer-const': 'error',
    'prefer-spread': 'off',
    'prefer-reflect': 'off',
    'prefer-rest-params': 'error',
    'prefer-template': 'error',
    'require-yield': 'off',
    'sort-imports': 'off',
    'template-curly-spacing': 'error',
    'yield-star-spacing': [ 'error', 'after' ],
    'strict': [ 'error', 'never' ],
    'block-spacing': [ 'error', 'always' ],
    'no-duplicate-imports': 'error',
    'no-useless-escape': 'warn',
    'max-statements-per-line': [ 'error', { 'max': 3 } ],
    'no-unsafe-finally': 'error',
    'no-useless-computed-key': 'error',
    'import/no-duplicates': 'error',
    'import/no-named-as-default': 'off',
    'import/no-unresolved': 'error',
    'no-empty-pattern': 'error',
    'react/display-name': [ 2, { 'ignoreTranspilerName': false } ],
    'react/jsx-boolean-value': [ 'error', 'never' ],
    'react/jsx-closing-bracket-location': [ 'error', 'line-aligned' ],
    'react/jsx-curly-spacing': [ 'error', 'never', { 'allowMultiline': true } ],
    'react/jsx-equals-spacing': [ 'error', 'never' ],
    'react/jsx-first-prop-new-line': 'off',
    'react/jsx-handler-names': 'off',
    'react/jsx-indent': [ 'error', 2 ],
    'react/jsx-indent-props': [ 'error', 2 ],
    'react/jsx-key': 'error',
    'react/jsx-max-props-per-line': [ 'error', { 'maximum': 4 } ],
    'react/jsx-no-bind': 'off',
    'react/jsx-no-duplicate-props': 'error',
    'react/jsx-no-literals': 'off',
    'react/jsx-no-undef': 'error',
    'react/jsx-pascal-case': 'error',
    'react/jsx-sort-props': 'off',
    'react/jsx-space-before-closing': 'error',
    'react/jsx-uses-react': 'error',
    'react/jsx-uses-vars': 'error',
    'react/no-danger': 'error',
    'react/no-deprecated': 'error',
    'react/no-did-mount-set-state': 'error',
    'react/no-did-update-set-state': 'error',
    'react/no-direct-mutation-state': 'error',
    'react/no-is-mounted': 'error',
    'react/no-multi-comp': 'off',
    'react/no-set-state': 'warn',
    'react/no-string-refs': 'error',
    'react/no-unknown-property': 'error',
    'react/prefer-es6-class': [ 'error', 'always' ],
    'react/prefer-stateless-function': 'error',
    'react/prop-types': 'off', // Going with flow types for stateless components
    'react/react-in-jsx-scope': 'error',
    'react/require-render-return': 'error',
    'react/self-closing-comp': 'error',
    'react/sort-comp': 'error',
    'react/sort-prop-types': 'off',
    'react/wrap-multilines': 'error',
    'import/default': 'error',
    'import/named': 'error',
    'import/namespace': 'error',
    'import/no-duplicates': 'error',
    'import/no-named-as-default': 'off',
    'import/no-unresolved': 'error',
    'import/extensions': [ 'error', { js: 'never', ts: 'never', jsx: 'never', tsx: 'never', json: 'always', css: 'always', scss: 'always', png: 'always' } ],
    'no-octal-escape': 'error',
    'no-extra-parens': [ 'error', 'functions' ],
    'no-irregular-whitespace': 'error',
  },
  plugins: [ 'import', 'react' ],
};
