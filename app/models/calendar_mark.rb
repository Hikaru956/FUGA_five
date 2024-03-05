class CalendarMark < ApplicationRecord
    belongs_to :shop
    belongs_to :staff


    TYPE_NONE       = 0
    TYPE_CIRCLE     = 10
    TYPE_TRIANGLE   = 20
    TYPE_BATSU      = 99
end
