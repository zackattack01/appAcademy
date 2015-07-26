class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates(
    :status,
    inclusion: { in: %w{ PENDING APPROVED DENIED },
    message: "Invalid status" }
  )

  validate :validate_overlap

  belongs_to :cat

  after_initialize { self.status ||= "PENDING" }


  private
    def any_overlap?(r1, r2)
      r1.start_date.between?(r2.start_date, r2.end_date)         ||
      r1.end_date.between?(r2.start_date, r2.end_date)           ||
      (r1.start_date < r2.start_date && r1.end_date > r2.end_date)
    end

    def overlapping_requests
      overlapping = []
      cat.cat_rental_requests.each_with_index do |request, idx_1|
          overlapping << request if any_overlap?(self, request)
      end

      overlapping
    end

    def overlapping_approved_requests?
      overlapping_requests.select do |request|
        request.status == "APPROVED"
      end.length > 0
    end

    def validate_overlap
      if overlapping_approved_requests?
        errors[:cat_rental_request] << "OVERLAPPING REQUEST DETECTED"
      end
    end
end
