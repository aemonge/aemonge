# 💻  Command line

## Iterate over strings of words with a for loop
```bash
STRS=("hola" "mundo" "bonito y azul"); for s in $STRS; do echo $s; done
```

## Clear the screen and run a query after the SQL script is updated:

`echo my.sql | entr -cp psql -f /_`

## Remove lines form command, multiple
> egrep -v 'word|other-word'
```bash
rspec spec/lib/demo_workspaces/bookings_creator_spec.rb | egrep --color=always -v 'Sidekiq|WARN: Job|^$'
rspec spec/lib/demo_workspaces/bookings_creator_spec.rb | awk '/^[^(Sidekiq|2022)].*$/{print'
```

## Bash here-document, here-string
> (https://en.wikipedia.org/wiki/Here_document#Unix_shells)

* `<<<DELIMITER` is a here string, where `<<DELIMITER` is a here-document.
```bash
heredoc = <<DOC
  the end keyword must be at the beginning of the line
DOC

dashed = <<-DOC
  the end keyword can be indente here
  DOC

squiggly = <<~DOC
  strips leading indentation
  in each line
  DOC

 (cat <<  "  SQL"
  SELECT 'hello world';
  SQL
  ) | psql -U postgres
```

### Using variables from bash
```bash
WORLD="hello world"
(cat <<-SQL
  SELECT '$WORLD';
SQL
```

## Contatenate arguments with a delimiter
```bash
IFS='|'
NAMES=$*
echo $NAME # hola mundo|azul
```

## View all active colors
```bash
msgcat --color=test
```

## Ls of ports
```bash
lsof -i :631
```

## To remove m lines from the beginning and n from the end (print only N first lines or M last lines):

> (https://unix.stackexchange.com/questions/169079/negative-arguments-to-head-tail)
```bash
awk -v m=6 -v n=12 'NR<=m{next};NR>n+m{print line[NR%n]};{line[NR%n]=$0}'
```

## Search and replace with `sed`
```bash
sed -e 's/ /.*/'
```

# 💎 Ruby

### Iterate over objects
```ruby
@object.attributes.each { |n| puts n }
@object.attribute_names.each { |n| puts n }
```

### Conditional Assigment
> Note the indentation, seams unreadable but just do it like this
```ruby
very_very_very_very_very_lengthy_foo = if bar?
                                         'true'
                                       else
                                         'false'
                                       end
```

### Debugger console

`byebug` but this is better `binding.pry`

* n: Next
* c: continue

### binding.pry
> [pry](https://github.com/pry/pry#commands)
> [cheetsheet](https://gist.github.com/lfender6445/9919357)

[cheat sheet](https://gist.github.com/lfender6445/9919357)

### Check all the command-line tasks

`bundle exec rake --tasks`

### Show/Get property from an array
> (https://www.fastruby.io/blog/performance/rails/writing-fast-rails.html)

- **pluck**. Does not load each property_calendar into memory.
- **map**. Loads each property_calendar into memory then access the date.
```ruby
array.map(&:property)
array.pluck(:property) # If it's a ActiveRecord Collection
array.map { |x| x.first_level_iterator rs.map(&:property) }
```

### Array and funcional

### Sum, map, zip-ish
```ruby
chunks.map(&:count).inject(0, :+)
chunks.sum(&:count)
```

### Private lies
> Honey-badger, don't care
```ruby
.send('private_attribute')
```

## Rails

### Object Relationship Model :ORM
#### Cascasde destruction/elimination of

* `:destroy` : The associated objects are destroyed alongside this object by calling their destroy method. Instantiates all the records and destroys them one at a time, so with a large dataset, this could be slow
* `:delete_all` : All associated objects are destroyed immediately without calling their destroy method. Callbacks are not called.
* `nullify`: Simply make the filed null.

```ruby
  has_many :site_publishing_operators, dependent: :delete_all
  has_many :site_publishing_operators, dependent: :destroy
  has_many :site_publishing_operators, dependent: :nullify
```
Do the destruction in code or console:
```ruby
workspace.properties.find_each do |property|
  property.destroy!
end
# Dirty
workspace.properties.destroy_all
```

#### ERB nested attributes
```html:erb
<%= ft.fields_for :multifamily do |ftm| %>
  <div class="row fluid-container">
    <div class="col-md-6">
      <%= ftm.check_box :short, {}, true, false %>
      <%= ftm.label "Short Stays" %>
    </div>
    <div class="col-md-6">
      <%= ftm.check_box :long, {}, true, false %>
      <%= ftm.label "Long Stays" %>
    </div>
  </div>
<% end %>
```

### Console
#### Execute a query in the consoles
```bash
echo "Chameleon::GetBrands.call" | bundle exec rails c
bundle exec  rails runner 'puts Chameleon::GetBrands.call'
```

#### Execute a query in **production**/**heroku** console
```bash
cat hard-booking-cancelation.rb | heroku run -a lvdam-staging rails runner -
```

#### Concatenate tasks
```bash
ENV=test bundle exec rails db:create db:migrate
```

### Create a `0:1` relationship with the command-line
> where workspace is a Model
```bash
rails generate model demo_workspaces_settings \
  workspace:belongs_to occupancy:float stay_length_41_weeks:boolean \
  stay_length_44_weeks:boolean stay_length_51_weeks:boolean stay_length_summer:boolean \
  stay_length_short:boolean stay_length_long:boolean
```

### Add a field to a Model
> to the **workspace** model
```bash
rails generate migration AddDemoTypeToWorkspaces demo_type:string
```

### Add a gem to a Gemfile
```bash
bundle add <gem-name> <version> --group "development, test"
```

### View form helper for checkbox/boolean values
> They just work as expected, trust it when generating the `Model.new(controller_params)`

## *random* fuck it, to test it correly
In order to rightfully test a method with a random generation, we should lock the seed by with `srand(873459)`. Check
out this example:
```ruby
100.times { srand(23413); puts rand(10) }
```

## Safe open files
> (https://www.rubydoc.info/gems/rubocop/RuboCop/Cop/Security/Open)

    # bad
    open(something)
    open("| #{something}")
    URI.open(something)

    # good
    File.open(something)
    IO.popen(something)
    URI.parse(something).open

    # good (literal strings)
    open("foo.text")
    open("| foo")
    URI.open("http://example.com")

### Assign to a variable last execution
> like in bash `A=!!`
```ruby
a = _
```

# 🎁 SQL

## Replicate a database (no user connected)
```SQL
CREATE DATABASE my_new_database TEMPLATE my_old_database;
```

### If users are connected
```bash
pg_dump -Fc -f olddb.pgdump -d olddb &&\
createdb newdb &&\
pg_restore -d newdb olddb.pgdump
```

## Send a script.sql
```bash
psql -dpostgres -f readOnly.sql
```

## Create a user with super powers
```SQL
CREATE USER postgres SUPERUSER;
CREATE ROLE
```

## Duplicate a database

CREATE DATABASE my_new_database TEMPLATE my_old_database;

## Create a special user
```SQL
CREATE USER postgres_read;
GRANT SELECT, SHOW VIEW ON myapp_development.* TO postgres_read;
FLUSH PRIVILEGES;
```

## Delete a user
```SQL
DROP USER postgres_read
```

## SQL Explorer / Navigator
```bash
pgcli -dmyapp_development -U postgres
```

## Check for Objects of role for deleting a role :user
Just login to the pscli and try to `DROP [USER|ROLE] <name>` and follow

## Search using regex for multiple word matches
```SQL
SELECT id, name
  FROM  workspaces
  -- WHERE  name SIMILAR TO '%(word one|wordTwo| third word )%';
  WHERE  name ~* ANY('{word one|wordTwo| third word }');
```

# 📚 GIT

## Git workflow

### Update local branch with main, re-basing
```bash
git checkout main
git pull
git checkout '<your-branch-name>'
git rebase main
```

### Clean **main** history
#### start
```bash
  git checkout main
  git pull origin main --rebase
  git checkout -b feat/BAC-###/name
```

#### develop
```bash
  git add [files]
  git commit -m 'feat/docs/refactor/fix(module): text'
  git push origin feat/BAC-###/name
```

#### review
```bash
  git commit --fixup HEAD~1
```

#### submit, done
```bash
  git rebase main --interactive --autosquash
```

## Better pushing to other remotes
```bash
git push other-remote local-branch:target-branch
```

## Show last commit files and messages
```bash
git log -1 --name-status # Display the files
git show # Display the diff
```

## Undo the commit of a file in (last) a commit:
```bash
git rebase -i HEAD~1
# pick the commit to `e` edit
git reset HEAD package-lock.json
# git restore package-lock.json
git rebase --continue
```

## Remove / Clear 🔨 Hard a sub-module
> Note: a/submodule (no trailing slash)
1. git submodule deinit -f -- a/submodule
2. rm -rf .git/modules/a/submodule
3. git rm -f a/submodule

> Or, if you want to leave it in your working tree and have done step 0
3. git rm --cached a/submodule
3. (bis)  mv a/submodule_tmp a/submodule

## Add Specific Lines With Git Patch
```bash
git add -p {file} # --patch
```

## Commit staged `git add` to other commit, not the last
#### Not so elegant version of `--fixup`
```bash
git add file # or git add -p file
git commit --fixup {commitHashID}
```
#### Elegant version with `rebase`
```bash
git stash
git rebase HEAD~5 # and mark the target commit to `edit`
git stash pop
git add [-p] "<files>"
git stash
git commit --amend --no-edit
git rebase --continue
git stash pop
```

## Undo a `rebase`
```bash
git reflog
git reset --hard {123456}
```

## Stack checkouts pop/push/etc...
```bash
git checkout -
```

## Remove file from commit on rebase interactive mode, to clean the commit.
```bash
git reset HEAD^ <file>
```
Or but make sure you copy the file outside the repository before doing this.
```bash
git ch HEAD~1 <file>
```

# ⚙️  Dev-Ops: Heroku

## Push to custom Heroku app
```bash
# git remote add test-app1 https://git@heroku.com:test-app1.git
heroku git:remote -a test-app
```

# 🗒️ Vim

## Pipe from/to file
:%!<command>
gem install --no-user-install --install-dir=./mason/packages --bindir=./mason/bin --no-document rubocop-rails rubocop-rspec

## Auto sending keys, to auto-accept
```vim
:help execute()
:execute ":call jukit#convert#notebook_convert()\n y" " Almost here, just the Y isn't getting there
:help feedkeys()
```

# 🐍 Python

## Typing and abstract classes
> https://stackoverflow.com/questions/23831510/abstract-attribute-not-property

`pip install better-abc`

```python
from abc import abstractmethod
from better_abc import abstract_attribute, ABCMeta
class Animal(metaclass=ABCMeta):
  @abstractmethod
  def eat(self) -> None :
    pass

  @abstract_attribute
  def edible(self) -> list[str]|None :
    pass

class Cat(Animal):
  def __init__(self, foods): # Typing foods not supported
    self.edible = foods

  def eat(self):
    self.edible = self.edible[:-1]
```

## Debug

### pdb / ipdb | Python (intelligent) DeBugger

```python
import ipdb; ipdb.set_trace()
```

#### Command   Description

* p   Print the value of an expression.
* pp  Pretty-print the value of an expression.
* n   Continue execution until the next line in the current function is reached or it returns.
* s   Execute the current line and stop at the first possible occasion (either in a function that is called or in the current function).
* c   Continue execution and only stop when a breakpoint is encountered.
* unt   Continue execution until the line with a number greater than the current one is reached. With a line number argument, continue execution until a line with a number greater or equal to that is reached.
* l   List source code for the current file. Without arguments, list 11 lines around the current line or continue the previous listing.
* ll  List the whole source code for the current function or frame.
* b   With no arguments, list all breaks. With a line number argument, set a breakpoint at this line in the current file.
* w   Print a stack trace, with the most recent frame at the bottom. An arrow indicates the current frame, which determines the context of most commands.
* u   Move the current frame count (default one) levels up in the stack trace (to an older frame).
* d   Move the current frame count (default one) levels down in the stack trace (to a newer frame).
* h   See a list of available commands.
* h <topic>   Show help for a command or topic.
* h pdb   Show the full pdb documentation.
* q   Quit the debugger and exit.

## From dictionary to list and sets and back to track ids
```python
a = {'eight', 'zero', 'six', 'three', 'one', 'nine', 'seven', 'two', 'four', 'five'}
b = { x:i for i,x in enumerate(list(a)) } # {'two': 0, 'four': 1, 'six': 2, .....
s = { key for key,val in b.items() if val == 2 }.pop() # 'six'
```

## Print and remove the last line in the console, for a waiting/done behavior

```python
def test():
  print('waiting...', end='\r')
  time.sleep(2)
  print(end='\x1b[2K')
  print('done')

  print('\033[F\033[K') # Too specific
  print('\r', end='\r') # I would guess this is more global

test()
```

## Null or empty variables which are going to be ignored, but fetch through pair

```python
def pair():
  return {'foo', 'bar'}
_, bar = pair()
```

## 🔥 PyTorch

### Save from tensor image to a file, without any axis just the content
```python
import matplotlib.pyplot as pyplot

# where img is a tensor of [1, 784]
img = img.view(1, 28, 28).permute(1, 2, 0)
pyplot.imshow(img)
pyplot.axis('off')
pyplot.savefig(tmp_path, bbox_inches='tight', pad_inches=0, transparent=True)
```
#### And render the above image in the terminal
```python
import plotext as plt

plt.plot_size(40, 20)
plt.image_plot(tmp_path, fast=True)
plt.show()
```

## Regex in Python
```python
import re
re.sub(r'blue', 'yellow', 'hello blue world')
re.sub(r'(.*):, (\w*) (\w*)', r'\2 \1 \3', 'blue:, hello world')
```

## Jupiter
> `jupiter notebook *.ipynb`
> `jupyter lab --watch --autoreload`

Develop and render your notebooks in NeoVim directly [NeoVim|vim-jukit](https://github.com/luk400/vim-jukit)

#### Jupyter Extensions
> To auto reload the notebook, and to install more useful extensions.
```bash
jupyter labextension install jupyterlab-autoplay
jupyter labextension install jupyterlab-autoplay
```
##### Jupyter Extensions: [jupyterlab-autoplay](https://github.com/remborg/autoplay)
```json
{
  [...]
  "metadata": {
    "autoplay": {
        "autoRun": true,
        "hideCodeCells": true
    }
  }
}
```
OR on a html cell:
```html
%%html
<script>
    // AUTORUN ALL CELLS ON NOTEBOOK-LOAD!
    require(
        ['base/js/namespace', 'jquery'],
        function(jupyter, $) {
            $(jupyter.events).on("kernel_ready.Kernel", function () {
                console.log("Auto-running all cells-below...");
                jupyter.actions.call('jupyter-notebook:run-all-cells-below');
                jupyter.actions.call('jupyter-notebook:save-notebook');
            });
        }
    );
</script>
```

## 🐼 Matrix and vectors
### Transposing tips for a simple row-vector to column-vector

    print(features)
    > array([ 0.49671415, -0.1382643 ,  0.64768854])

    print(features.T)
    > array([ 0.49671415, -0.1382643 ,  0.64768854])

    print(features[:, None])
    > array([[ 0.49671415],
           [-0.1382643 ],
           [ 0.64768854]])

#### Alternatively

    np.array(features, ndmin=2)
    > array([[ 0.49671415, -0.1382643 ,  0.64768854]])

    np.array(features, ndmin=2).T
    > array([[ 0.49671415],
           [-0.1382643 ],
           [ 0.64768854]])

# 🔣 Regex
> The notion that regex doesn't support inverse matching is not entirely true.

* `^((?!notWord).)*$`
* `^(?:(?!:notWord).)*$`
* `^((?!(notWord|norWord)).)*$`

## To see messages per file and line
**nvim** `'<,'>s/\(:[^ ]*\)/\1/g`

# 🏢 AWS | Amazon Web Services

## Relationship databases done better
> Amazon Neptune
* Alternatively they have amazon block chain
* Or Amazon Quantum Ledger Database, for financial purposes.

## AWS Interfaces (GUI, CLI, SDK, and beans)
> You can simply use the CLI or SDK tools, instead of the Bean/CF

### Elastic Beanstalk
> To manage all the infrastructure as a code, duplicate rinse repeat delete...

* Alternatively CloudFormatiion, which is a bit more technical since its declarative.

## Lambda Functions
> They are meant for servies that take less that 15mins to work.

Alternatively you can have either a A-ECS (elastic container service) A-EKS (elastic kubernetes service)

Even more business oriented, use server-less *Fargate* to complete forget the underline of ECS/EKC rather than instances.

## Terraform

Big folders are namespaces.

## Ingress
They are all about serving traffic to the outside world. To avoid having every service with an public IP, the Ingress's
serve as an API Gateway.

- And POD's talk by using services.

### Ingress Controller
A proxy (revese proxy), is like an having nGinx , configured through a YAML file.

# 💡 Thoughts

## AI

### BartrAIND Russell
> The whole problem with Artificial Intelligence is that bad models are so certain of themselves, and good models so
> full of doubts.

# 🤖 Artificial Intelligence

## AWS | Data Warehouse
> for 10 years ago, within 10 different data schemas

Amazon *RedShift*, supports exabytes for a single query

## Libraries
I ❤️  the `pandas` library, but note that 🔥 `torch` and `numpy` are lovers

### Pytorch 🔥 🕶️  torch-vision
> Don't forget to clear your gradients, before staring to train your network with `optimizer.zero_grad()`

#### Save your trained model
> Make sure the architecture of the saved are respected, aka the matrix definition.
```python
torch.save(model.state_dict(), 'checkpoint.pth')
model.load_state_dict(torch.load('checkpoint.pth'))
checkpoint = {
  'input_size': 784, 'output_size': 10,
  'hidden_layers': [ l.out_features for e in model.hidden_layers],
  'state': model.state_dict()
} # Use this Structure to save and load, better. Since it contains a simple description of the architecture.
```

### 🪐 Jupiter
Untill the real refresh is done, just `jupyter notebook --autoreload  --no-browser -y 4-Fashion-MNIST-_Exercises_.ipynb`

#### Error loading the dependencies.
In your *notebook.ipynb*:
```python
# Jupiter needs me to manually re-install the dependencies from pip
!pip install torch torchvision helper
```
#### Data images to play and train
```python
# Define a transform to normalize the data
transform = transforms.Compose([transforms.ToTensor(),
                                transforms.Normalize((0.5,), (0.5,))])
# Download and load the training data
trainset = datasets.FashionMNIST('./.F_MNIST_data/', download=True, train=True, transform=transform)
trainloader = DataLoader(trainset, batch_size=32, shuffle=True)

# Download and load the test data
testset = datasets.FashionMNIST('./.F_MNIST_data/', download=True, train=False, transform=transform)
testloader = DataLoader(testset, batch_size=32, shuffle=True)

```

# 📄 PDF `gs` ghost script

## Compress a pdf file
> (https://opensource.com/article/20/8/reduce-pdf)
```bash
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
-dNOPAUSE -dBATCH -dColorImageResolution=150 \
-sOutputFile=output.pdf someBigFile.pdf
```

# Mac 🍎

## Fix Crackling or Garbled Sound By Killing Core Audio
```bash
sudo killall coreaudiod`
```
