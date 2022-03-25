class Inquiry < ApplicationRecord
    belongs_to :shop

    INQ_OPEN    = 0
    INQ_WORKING = 1
    INQ_CLOSE   = 2
end
