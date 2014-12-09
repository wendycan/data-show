module.exports = function(grunt) {
  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    uglify: {
      options: {
        compress: {
          drop_console: true
        }
      },
      dep: {
        src: ['node_modules/jquery/dist/jquery.min.js', 'node_modules/chart.js/Chart.min.js'],
        dest: 'public/javascripts/deps.js'
      }
    },
    coffee: {
      compile: {
        files: {
          'public/javascripts/all.js' : 'src/javascripts/*.coffee'
        }
      }
    },
    sass: {
      dist: {
        options: {
          style: 'expanded'
        },
        files: {
          'public/stylesheets/style.css' : 'src/css/*.scss'
        }
      }
    },
    watch: {
      coffee: {
        files: ['src/javascripts/*.coffee'],
        tasks: ['coffee']
      },
      scss: {
        files: ['src/css/*.scss'],
        tasks: ['sass']
      }
    },
    cssmin: {
      css: {
        src: 'src/css/*.scss',
        dest:'public/stylesheets/style.css'
      }
    }
  });
  // Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-css');
  grunt.loadNpmTasks('grunt-contrib-watch');
  // Default task(s).
  grunt.registerTask('default', ['coffee', 'sass', 'uglify']);
};
