# == Class autofs::config
#
# This class is called from autofs for service config.
#
class autofs::config {
  if !defined(Concat[$autofs::config_file]) {
    concat { $autofs::config_file:
      owner => $autofs::config_file_owner,
      group => $autofs::config_file_group,
      mode  => $autofs::config_file_mode,
    }

    concat::fragment { "${autofs::config_file} preamble":
      target  => $autofs::config_file,
      content => "# File managed by puppet, do not edit\n",
      order   => '01',
    }
  }

  create_resources(autofs::mount, $autofs::mounts)

  create_resources(autofs::mountfile, $autofs::mount_files)

  create_resources(autofs::mountentry, $autofs::mount_entries)

}
