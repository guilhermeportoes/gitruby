##########################  HOW IT SHOULD BE (basically) #########################
############ USER ###########
user = User.find('bernardofire')      #find or new ?
user.name      # bernardofire
user.followers # list of User objects
user.following # list of User objects
user.repos     # list of Repo objects
user.gists     # list of Gist objects
user.assigned_issues
user.issues_create

##### USER ACTIONS #####
user = User.find('bernardofire')
## require authentication
# do .save to update information
user.email = 'bernardo@foo.com'
user.bio = 'NSI programmer'
user.save     # makes the update
## Real time update
user.follow :johndoe
user.unfollow :johndoe
user.unfollow_all  # maybe
user.follow_all_of 'nsi-iff'  #maybe

############ REPO ############
repo = Repo.new('bernardofire', 'fdo')
# TODO, someday, maybe!: repo.fork should return all forks as a repo object # I don't know if the github API support it,
# and it'll be really slow... a lot of requests...
#
# do some magic to make boolean methods, like: $ 'fork': 'false' --> $ fork? #=> true
# user.repos api url return a list with all your repos and their information, each field of the information is a key. when you pass a hash to the Repo.new
# it should create a object, with each dict key being a method and the value be the return
repo = Repo.new name: 'foo', language: 'javascript', owner: 'bernardofire'
# ex:
repo.language #=> 'javascript'
repo.name #=> 'foo'
repo.owner #=> 'bernardofire'
#....

############################# TODO ############################
# 1- Create User, without authentication, just
# 2- Create Repo
