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
      version: '0.0.1',
      banner: '/*!\n * Katalyst Education - Playground - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        ' * http://katalysteducation.org/\n' +
        ' * Copyright (c) <%= grunt.template.today("yyyy") %>\n */\n'

    clean:
      js: ['dist/scripts/*.js', '!dist/scripts/main.js']

    copy:
      dev:
        expand: true
        cwd: 'src'
        src: [
          'images/**'
          'index.html'
        ]
        dest: 'dist/'
      dist:
        expand: true
        cwd: 'src'
        src: ['images/**']
        dest: 'dist/'

    coffee:
      compile:
        expand: true
        flatten: true
        cwd: "#{__dirname}/src/scripts/"
        src: ['*.coffee']
        dest: 'dist/scripts/'
        ext: '.js'

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

      # Copy Vendor CSS
      # css:
      #   files: ['src/vendor/css/**/*.css']
      #   tasks: 'copy:build'

      img:
        files: ['src/images/**/*']
        tasks: 'copy:build'

    concat:
      build:
        options:
          banner: '<%= meta.banner %>'
        src:  [
          'dist/scripts/**/*.js'
          'node_modules/jquery/dist/jquery.min.js'
          'node_modules/bootstrap/dist/js/bootstrap.min.js'
        ]
        dest: 'dist/scripts/main.js'

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
  grunt.registerTask('default', ['copy:dev', 'coffee', 'less:build', 'watch']);

  # Build task
  grunt.registerTask 'build', ['copy:dist', 'coffee', 'less:build', 'concat:build', 'uglify', 'processhtml:dist', 'clean']
