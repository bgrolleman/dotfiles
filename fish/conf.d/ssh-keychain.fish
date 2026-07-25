# Start keychain and source SSH agent variables for all private keys in ~/.ssh
if status is-interactive
    if type -q keychain
        set -l _ssh_keys
        for _pub in ~/.ssh/*.pub
            set -l _key (string replace -r '\.pub$' '' $_pub)
            if test -f $_key
                set -a _ssh_keys $_key
            end
        end
        if test (count $_ssh_keys) -gt 0
            keychain --eval --quiet $_ssh_keys | source
        end
    end
end
