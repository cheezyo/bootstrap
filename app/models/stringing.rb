class Stringing < ApplicationRecord

	def paid?
		self.paid != nil 
	end

	def deilivered? 
		self.pick_up != nil
	end

	def done? 
		self.done != nil
	end

	def self.get_un_paid
		Stringing.where(paid: nil)
	end

	def get_un_paid_and_done
		Stringing.where(paid: nil).where.not(done: nil).order(created_at: :asc)
	end


	def self.get_not_paid_and_done
		Stringing.where.not(done: nil).where(paid: nil).order(done: :desc)
	end

	def self.get_queue
		#Stringing.where.not(paid: nil).where(done: nil).order(paid: :asc)
		Stringing.where(done: nil).order(created_at: :desc)
	end

	def get_day_from_delivery

	end

end
