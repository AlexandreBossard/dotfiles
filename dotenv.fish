function dotenv --description 'Load environment variables from .env file' --argument envfile
  set -l envfile ".env"
  if [ (count $argv) -gt 0 ]
    set envfile $argv[1]
  end

  if test -e $envfile
    for line in (grep '^[^#]' $envfile)
      set -l kv (string split --max 1 '=' $line)
      set -l rawvalue (string replace -r '\$\{(.*?)\}' '\{\$$1\}' -- (string unescape -- $kv[2]))
      set -l vv (string escape -- {$rawvalue})
      if string match -q -r -v "^'" -- $vv; and set -q -- $vv
        echo SET2 $kv[1] $$rawvalue
        set -xg $kv[1] $$rawvalue
      else
        set -l expanded (eval echo $rawvalue)
        echo SET $kv[1] $expanded
        set -xg $kv[1] $expanded 
      end
    end
  else
    echo "file $envfile not found"
    return 1
  end

end

