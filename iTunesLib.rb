module ITunes
	def self.app
		begin
			itunes = System::Activator.create_instance(System::Type.get_type_from_prog_i_d("iTunes.Application"))
			yield itunes
		rescue Exception => e
			puts e
		ensure
			System::Runtime::InteropServices::Marshal.release_com_object(itunes) if !itunes.nil?
		end
	end
end
