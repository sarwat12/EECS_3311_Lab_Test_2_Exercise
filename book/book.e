note
	description: "EECS3311 Lab Test 2"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOK[V1, V2, K]

create
	make

feature {NONE} -- Implementation attributes
	keys: ARRAY[K]
	values_1: LINKED_LIST[V1]
	values_2: LINKED_LIST[V2]

feature -- Iterable-related features
	-- Your Task

feature -- Public Attributes
	count: INTEGER -- You must keep this as an attribute.

feature -- Constructor
	make
			-- Initialize an empty book.
		do
			-- Your Task
			keys.compare_objects
		ensure
			empty_book: True -- Your Task
			keys.object_comparison
		end

feature -- Commands

	add (v1: V1; v2: V2; k: K)
			-- Add values 'v1' and 'v2' associated with key 'k'.
		require
			non_existing_key: True -- Your Task
		do
			-- Your Task
		end

feature -- Query

	get_keys (v1: V1; v2: V2): ITERABLE[K]
			-- Return an iterable collection of keys,
			-- each of which has the associated values 'v1' and 'v2'.
		do
			-- Your Task
		end

invariant
	consistent_counts:
				keys.count = count
		and 	keys.count = values_1.count
		and 	keys.count = values_2.count
end
