module ITunes
	def self.app
		begin
			itunes_type = System::Type.get_type_from_prog_i_d("iTunes.Application")
			itunes = System::Activator.create_instance(itunes_type)
			yield itunes
		rescue Exception => e
			puts e
		end
	end
end
