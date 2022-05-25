# Local Gnomes

## Challenge:

Every time the heroes they play arrive at a town, they have the issue they don't know the local population and what they can do to help them on their adventures. To facilitate trade with the local population they need an easy way to browse all the inhabitants details.

Show this data in the most user-friendly way you could think. Keep in mind our heroes will be quite busy dealing with Orcs, so apps have to be really simple and easy to use. At least would be good to quickly browse (and even filter) all the individuals and be able to see the details of each one.

- Document all libraries used and explain the reason you’ve used that library.
- Test the app: add the most important test you think it is needed.
- UI must not blocked by network connections or long operations
- Images coming from network cached to improve performance
- Use third party libraries for extended functionality
- Snappiness & responsiveness over sluggishness & idleness
- Document all libraries used and explain the reason you’ve used that library.

## Explanation:

### SwiftUI over UIKit:
In order to reduce the overall amount of code and improve perfomance, SwiftUI with a combination of async/await were used in this project

### No third libraries:
Because AsyncImage is best in SwiftUI for images cache/load and also Lists with LazyVStack (for big amount of items without much hassle) there wasn't a reason to use a third-party library for this project.

### Profession over name:
Gnomes names as well as their random profile pictures are irrelevant for our heroes since they don't know who they are. However, professions are. Thats why the main view present a list of professions with the name of the gnome below it.

### Filter by name & profession:
Filtering just by name won't help our hero (Even thought he might find one at Brastlewark). Professions like Medic or Cook can determine which Gnomes are needed in a specific time. Hence the decision of filter both by name and profession.

### Access to friend's details:
Gnome's friends are relevant, they have a relation that might help our heroes to better understand Brastlewark and could be used as a better way to get help from them.

### Color scheme:
Darker green over lighter green backgrounds and white/black fonts are used to mainly highlight text since images are not

### Gnome Gender:
One strategy used to determine Gnome's gender was their hair color. Might not be totally effective but could help our heroes.

### Expansion:
App was design to be used for different places other than Brastlewark. A place selection list can be extended with different census data but with the same functionality

### Testing:
Three cases were considered in testing: Correctly loading Brastlewark data, filter by a keyword and load friends for an specific Gnome.
