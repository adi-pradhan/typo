Feature: Create Category
	As an Admin
	In order to organize the Blog
	I want to Create a Category
  
  	Background:
    	Given the blog is set up
    	And I am logged into the admin panel

	Scenario:
		When I follow "Categories"
		Then I should be on the "New Category Page" 