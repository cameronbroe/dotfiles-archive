module VimScripts
    def self.moo
        print 'moo from Ruby!'
        Vim::command("echom 'moo'")
    end

    class Foo
        def self.bar
            Vim::command("echom 'bar'")
        end

        def self.test
            buff = Vim::Buffer.current
            10.times do |n|
                buff.append(n, n.to_s)
            end
        end
    end
end
