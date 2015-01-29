Feature: Merge Articles
	As a Blog Administrator
	In order to remove duplicated articles
	I want to be able to Merge Articles

	Background: articles and users have been added to the database

		Given the blog is set up

		Given the following users exist:
		| profile_id | login | name   | password | email    | state  |
		| 2			 | user2 | two    | password | t@t.com  | active |
		| 3			 | user3 | three  | password | t@t.com  | active |

		Given the following articles exist:
            | id | title    | author | user_id | body     | allow_comments | published | published_at        | state     | type    |
            | 3  | Article1 | user2 | 2       | Content1 | true           | true      | 2012-23-11 21:30:00 | published | Article |
            | 4  | Article2 | user3 | 3       | Content2 | true           | true      | 2012-24-11 22:00:00 | published | Article |

        Given the following comments exist:
            | id | type    | author | body     | article_id | user_id | created_at          |
            | 1  | Comment | user2 | Comment1 | 3          | 2       | 2012-23-11 21:31:00 |
            | 2  | Comment | user2 | Comment2 | 4          | 2       | 2012-24-11 22:01:00 |

    Scenario: As a non-admin I cannot merge articles
    	Given I am logged in as "user2" with pass "password"
    	And I am on the Edit Page of Article with id 3
    	Then I should not see "Merge Articles"

    Scenario: As an Admin I am able to merge articles
    	Given I am logged in as "admin" with pass "aaaaaaaa"
    	And I am on the Edit Page of Article with id 3
    	Then I should see "Merge Articles"
    	When I fill in "merge_with" with "4"
    	And I press "Merge"
    	Then I should be on the admin content page
    	And I should see "Articles successfully merged!"

    Scenario: The Merged articles should contain the content of both articles
    	Given the articles with id "3" and "4" were merged
    	And I am on the Home page
    	Then I should see "Article1"
    	When I follow "Article1"
    	Then I should see "Content1"
    	And I should see "Content2"

    Scenario: The author of the merged articles is the first author
    	Given the articles with id "3" and "4" were merged
    	Then "User1" should be the author of 1 articles
    	And "User2" should be the author of 0 articles

    Scenario: The comments of merged articles should be combined
    	Given the articles with id "3" and "4" were merged
    	And I am on the home page
    	Then I should see "Article1"
    	When I follow "Article1"
    	Then I should see "Comment1"
    	And I should see "Comment2"

    Scenario: The title of the merged article should be the first title
    	Given the articles with id "3" and "4" were merged
    	And I am on the home page
    	Then I should see "Article1"
    	And I should not see "Article2"






