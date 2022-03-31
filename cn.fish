function _is_in_git_repository
  if test (git rev-parse --is-inside-work-tree 2> /dev/null; or echo "false") = "true"
    return 0
  else
    return 1
  end
end

function cn

  set -l arguments
  set arguments $arguments (fish_opt -s p -l profile -r)
  set arguments $arguments (fish_opt -s o -l options -r --multiple-vals)
  set arguments $arguments (fish_opt -s r -l recipe_path -r --multiple-vals)
  set arguments $arguments (fish_opt -s d -l deps -r --multiple-vals)
  set arguments $arguments (fish_opt -s u -l update)
  set arguments $arguments (fish_opt -s s -l settings -r --multiple-vals)
  set arguments $arguments (fish_opt -s i -l install)
  set arguments $arguments (fish_opt -s b -l build)
  set arguments $arguments (fish_opt -s c -l configure)
  set arguments $arguments (fish_opt -s t -l test)
  set arguments $arguments (fish_opt -s n -l dry-run)
  argparse $arguments -- $argv; or return 1

  set -l dontconfigure

  set -l profile
  if set -q -l _flag_profile
    set profile '--profile='{$_flag_profile}
  end

  set -l options
  if set -q -l _flag_options
    set options '--options='{$_flag_options}
    set -e dontconfigure
  end

  set -l deps
  if set -q -l _flag_deps
    set deps '--build='{$_flag_deps}
    set -e dontconfigure
  end

  set -l doupdate
  if set -q -l _flag_update
    set doupdate '--update'
    set -e dontconfigure
  end

  set -l settings
  if set -q -l _flag_settings
    set settings '--settings='{$_flag_settings}
    set -e dontconfigure
  end

  set -l install
  if set -q -l _flag_install
    set -e dontconfigure
    set install '--install'
  end

  set -l configure
  if set -q -l _flag_configure
    set -e dontconfigure
    set configure '--configure'
  end
  set -l dotest
  if set -q -l _flag_test
    set dotest '--test'
  end

  set -l build
  if set -q -l _flag_build
    set build '--build'
  end

  set -l recipe_path
  if set -q -l _flag_recipe_path
    set recipe_path $_flag_recipe_path
  end

  set -l worktree
  if test -z $recipe_path
    if not _is_in_git_repository
      echo "not in a repository"
      return 1
    end
    set -l git_root (command git rev-parse --show-cdup)
    if test -z $git_root
      set git_root .
    end
    set worktree (realpath $git_root)
  else
    set worktree (realpath $recipe_path)
    if test -f $worktree
      set worktree (command dirname $worktree)
    end
  end

  set -l buildsuffix default

  if set -q -l _flag_profile
    set buildsuffix $_flag_profile
  end
  set -l builddir (string join - build {$buildsuffix})

  set -l relbuilddir (string join / {$worktree} {$builddir})

  if not test -d $relbuilddir
    set -e dontconfigure
    command mkdir -p $relbuilddir; or return 1
    echo directory made
  end

  if not set -q -l dontconfigure
    command conan install $worktree $profile $settings $doupdate $deps $options -if $relbuilddir; or return 1
  end

  command conan build $worktree -bf $relbuilddir $build $configure $dotest $install; or return 1

  return 0 
end

