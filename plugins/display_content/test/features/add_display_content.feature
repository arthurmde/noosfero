Feature:
	In order to add a display content block
	As a logged user
	I want to add display content block

	Background:
		Given the following users
		| login | name |
		| joaosilva | Joao Silva |
		And the following plugin
		| klass |
		| DisplayContentPlugin |
		And plugin DisplayContentPlugin is enabled on environment
		And the following blocks
		| owner | type |
		| joaosilva | DisplayContentBlock |
		And the following blogs
		| owner     | name     |
   		| joaosilva | Blog One |
   		And the following articles
     	| owner | name  | parent       |
        | joaosilva | Post1 | Blog One  |
        | joaosilva | Post2 | Blog One  |
        | joaosilva | Post3 | Blog One  |
		And I am logged in as "joaosilva"
		

	Scenario: a user can add a Display Content block
		Given I go to joaosilva's control panel
		And I follow "Edit sideboxes"
		When I follow "Add a block"
		Then I should see "Display your contents" within ".block-types"

	Scenario: a user can add and edit a Display Content block
		Given I go to joaosilva's control panel
		When I follow "Edit sideboxes"
		And I follow "Edit" within ".display-content-block"
		And I fill in "block_title" with "My contents"
		And I fill in "block_item_count" with "1"
		And I press "Save"
		Then I should see "My contents"


	