require 'pry'

class Pokemon
	attr_accessor :name, :type, :db, :id, :hp

	def initialize (values)
		values.each {|key, value| self.send("#{key}=", value)}
		if @db.execute("SELECT * FROM pokemon WHERE name = '#{@name}'") == []
			@db.execute("INSERT INTO pokemon (name, type) VALUES ('#{@name}', '#{@type}')")
		end
	end
	def alter_hp(new_hp, db)
		@hp = new_hp
		db.execute("UPDATE pokemon SET hp = #{@hp} WHERE id = '#{@id}'")
	end
	def self.save(name, type, db)
		Pokemon.new({name: name, type: type, db: db})
	end

	def self.find(id, db)
		poke_data = db.execute("SELECT * FROM pokemon WHERE id = #{id}")
		self.new({id: id, name: poke_data[0][1], type: poke_data[0][2], db: db, hp: poke_data[0][3]})
	end


end
