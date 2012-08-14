require 'test_classes/users'
require 'test_classes/projects'
module GrapeDoc
  class API < Grape::API
    mount Projects
    mount Users
  end
end

