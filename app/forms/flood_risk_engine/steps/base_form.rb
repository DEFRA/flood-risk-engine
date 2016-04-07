require_dependency "reform"

# Could be a mixin?
# Could add common functionality here allow subclases to specify specifics
# e.g. key into the params hash, the model to initialize reform with
# (eg using a proc?) etc. At the very least this lets us move out the common
# 'require_dependency' to here rather than having it in each form object;
# seems to be required or reform not available evenif required in engine.rb.
#
module FloodRiskEngine
  module Steps
    class BaseForm < Reform::Form
    end
  end
end
