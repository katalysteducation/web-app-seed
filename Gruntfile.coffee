module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-processhtml'

  # Project configuration.
  grunt.initConfig

    meta:
      version: '0.1.3',
      banner: '/*!\n * Katalyst Education - Web-App-Seed - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        ' * http://katalysteducation.org/\n' +
        ' * Copyright (c) <%= grunt.template.today("yyyy") %>\n */\n'

    clean:
      dev: 'dist/scripts/main.coffee'
      dist: ['dist/scripts/*.js', '!dist/scripts/main.js']

    # Copy required assets and catalogs.
    copy:
      dev:
        expand: true
        cwd: 'src'
        src: [
          'templates/**'
          'locales/**'
          'images/**'
          'index.html'
        ]
        dest: 'dist/'
      dist:
        expand: true
        cwd: 'src'
        src: [
          'templates/**'
          'locales/**'
          'images/**'
        ]
        dest: 'dist/'

    # Concatenate CoffeScript/JavaScript files.
    concat:
      dev:
        src:  'src/scripts/*.coffee'
        dest: 'dist/scripts/main.coffee'

      build:
        options:
          banner: '<%= meta.banner %>'
        src:  [
          # Get jQuery.
          'node_modules/jquery/dist/jquery.min.js'
          # Get Bootstrap.
          'node_modules/bootstrap/dist/js/bootstrap.min.js'
          # Get Handlebars.
          'node_modules/handlebars/dist/handlebars.min.js'
          # Get L20n.
          #'node_modules/l20n/dist/compat/web/l20n.min.js'
          # Get JS files.
          'dist/scripts/**/*.js'
        ]
        dest: 'dist/scripts/main.js'

    coffee:
      compile:
        options:
          join: true
        files:
          'dist/scripts/main.js': ['src/scripts/*.coffee']

    less:
      build:
        options:
          compress: true
        files:
          "dist/styles/main.css": "src/styles/main.less"

    watch:
      coffee:
        files: ['src/scripts/**/*.coffee']
        tasks: ['coffee:compile']

      less:
        files: ['src/styles/**/*.less']
        tasks: 'less:build'

      options:
        livereload:true

      img:
        files: ['src/images/**/*']
        tasks: 'copy:build'

      assets:
        files: ['src/index.html','src/templates/*.hbs','src/locales/*.ftl']
        tasks: 'copy:dev'

    uglify:
      app:
        options:
          banner: '<%= meta.banner %>'
        files:
          'dist/scripts/main.js': ['<%= concat.build.dest %>']

    processhtml:
      options:
        data:
          message: 'Hello world!'
      dist:
        files:
          'dist/index.html': ['src/index.html']

  # Default task.
  grunt.registerTask('default', [
    'copy:dev'
    'coffee'
    'less:build'
    'watch'
  ]);

  # Build task
  grunt.registerTask 'build', [
    'copy:dist'
    'coffee'
    'less:build'
    'concat:build'
    'uglify'
    'processhtml:dist'
    'clean:dist'
  ]
