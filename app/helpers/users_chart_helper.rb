module UsersChartHelper  
	def users_chart_series()  
		[10, 20, 30, 40, 50, 60, 70, 80, 90].map do |age|  
			users_count = User.where("age >= ? AND age < ?", age, age + 10).count
			users_count.to_i  
		end.inspect
	end
end