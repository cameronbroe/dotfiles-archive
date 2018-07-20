module VimScripts
    def self.moo
        Vim::command("echom 'moo'")
    end

    class Foo
        def self.bar
            Vim::command("echom 'bar'")
        end
    end
end
