module Polycon
    module Models
        class Professional
            attr_accessor :name
            def initialize(name)
                @name=name
            end

            def create_folder()
                Dir.mkdir(Helpers.path<<"/#{@name}")
            end

            def self.exist?(name) #verify if a folder w/ that name exists
                Dir.exist?(Helpers.path<<"/#{name}")
            end

            def self.rename_professional(old_name, new_name)
                File.rename(Helpers.path << "/#{old_name}" , Helpers.path << "/#{new_name}")
            end

            def self.list_professionals()
                Dir.children(Helpers.path)
            end

            def self.delete_professional(name)
                begin
                    Dir.delete(Helpers.path << "/#{name}") #"Dir.delete" produce an error if the file is not empty
                rescue SystemCallError
                    return false
                else
                    return true
                end
            end
        end
    end
end