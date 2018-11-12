require 'digest'

module VimScripts
    class Hash
        def self.sha256
            buffer = Vim::Buffer.current
            lines = []
            (1..buffer.length).each do |n|
                lines.append(buffer[n])
            end
            lines = lines.join('\n')
            Vim::command("echom \"sha256 hash of #{buffer.name} - #{Digest::SHA256.hexdigest lines}\"")
        end
    end
end
