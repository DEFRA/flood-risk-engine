module FloodRiskEngine
  class ContactPresenter

    def initialize(contact)
      @contact = contact
    end

    # Returns a friendly single line representation of the contact, e.g.
    # John Smith (Site Manager)
    def to_s
      return unless contact
      title = contact.full_name
      title += " (#{contact.position})" unless contact.position.blank?
      title
    end

    private

    attr_reader :contact
  end
end
