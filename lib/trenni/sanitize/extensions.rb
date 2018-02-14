
class Hash
	unless defined?(slice)
		def slice(*keys)
			self.select{|key, value| keys.include? key}
		end
	end
	
	unless defined?(slice!)
		def slice!(*keys)
			self.select!{|key, value| keys.include? key}
		end
	end
end
