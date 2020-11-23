module Concerns::Findable
def find_by_name(name)
    self.all.detect {|item| item.name == name} #Detect returns the first item in the list for which the block returns TRUE
end
def find_or_create_by_name(name)
    if !self.find_by_name(name)
        self.create(name)
    else 
        return self.find_by_name(name)
    end
end

end