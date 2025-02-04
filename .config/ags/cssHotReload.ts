import { App } from 'astal/gtk4'
import { exec, execAsync, GLib, monitorFile } from 'astal'

export function compileScss(): string {
  try {
    exec(`sass ${SRC}/style.scss /tmp/style.css --load-path="${GLib.get_user_state_dir()}/retro"`)
    App.apply_css('/tmp/style.css')
    return `/tmp/style.scss`
  } catch(err) {
    execAsync(`notify-send 'retro' 'Scss' 'Failed to compile scss.'`)
    return ''
  }
}

// Hot Reload Scss
(function() {
  const scssFiles =
    exec(`find -L ${SRC} -iname '*.scss'`)
      .split('\n')

  // Add the symlink ags_theme.scss to the files to watch
  scssFiles.push(`${GLib.get_user_state_dir()}/retro/ags_theme.scss`)

  // Compile scss files at startup
  compileScss()

  scssFiles
    .forEach(file =>
      monitorFile(file, compileScss)
    )
})()
