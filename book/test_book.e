note
	description: "Example Test of BOOK"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_BOOK

inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Add tests.
		do
			add_boolean_case (agent test_book)
			show_browser
			run_espec
		end

feature

	test_book: BOOLEAN
		local
			-- Each entry book stores a person's name and birth date.
			-- Each entry is uniquely identified by an integer search key.
			b: BOOK[STRING, DATE, INTEGER]
			tuples: LINKED_LIST[TUPLE[STRING, DATE]]
			tic: TUPLE_ITERATION_CURSOR[STRING, DATE]
			keys: ARRAY[INTEGER]
			ks: ITERABLE[INTEGER]
		do
			comment ("test_book: illustrating API of BOOK")

			create b.make
			Result := b.count = 0
			check Result end

			-- Add Suyeon's birthday with the search key 1.
			b.add ("Suyeon", create {DATE}.make (2013, 8, 31), 1)
			-- Add Yuna's birthday with the search key 2.
			b.add ("Yuna", create {DATE}.make (2016, 6, 20), 2)
			Result := b.count = 2
			check Result end

			create tuples.make
			across
				b as cursor
			loop
				tuples.extend (cursor.item)
			end
			Result :=
						tuples.count = 2
				and 	tuples[1].item (1) ~ "Suyeon"
				and 	tuples[1].item (2) ~ (create {DATE}.make (2013, 8, 31))
				and 	tuples[2].item (1) ~ "Yuna"
				and 	tuples[2].item (2) ~ (create {DATE}.make (2016, 6, 20))
			check Result end

			-- Reset the tuples
			create tuples.make
			check attached {TUPLE_ITERATION_CURSOR[STRING, DATE]} b.new_cursor as nc then
				tic := nc
			end
			from
			until
				tic.after
			loop
				tuples.extend (tic.item)
				tic.forth
			end
			Result :=
						tuples.count = 2
				and 	tuples[1].item (1) ~ "Suyeon"
				and 	tuples[1].item (2) ~ (create {DATE}.make (2013, 8, 31))
				and 	tuples[2].item (1) ~ "Yuna"
				and 	tuples[2].item (2) ~ (create {DATE}.make (2016, 6, 20))
			check Result end

			create keys.make_empty
			ks := b.get_keys ("Suyeon", create {DATE}.make (2013, 8, 31))
			across
				ks as cursor
			loop
				keys.force (cursor.item, keys.count + 1)
			end
			Result :=
						keys.count = 1
				and	keys[1] = 1
			check Result end
		end
end
