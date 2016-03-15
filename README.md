# *The Fordham Museum App*

**The Fordham Museum App** is an app to assist with the navigation and experience of the Fordham University Museum of Greek, Etruscan, and Roman Art.

**Design Questions**
- [ ] Can we create the Tab View Controller programmatically so that we do not need to have 3 different view controllers for the greek, etruscan, and roman filters?

**Design Features**
- [ ] User sees Fordham Maroon and Benjamin Moore Blueberry color scheme
- [ ] User sees Auto-layout used throughout

## Required User Stories

**Launch**
- [ ] User sees Custom Launch Screen
- [x] User sees Home screen

**CollectionView**
- [ ] User sees Collection View that is populated with museum artifacts and info.
- [x] User sees a tab bar that allows for selection between greek, etruscan, and roman filters.
- [ ] User sees naviagation bar buttons that allow for access to search, twitter feed, and student audio tour
- [ ] User is able to scroll infinitely through objects
- [ ] User can tap on each cell to access a detail view of the selected artifact.
- **Note.** There is a preexisting API with these data available. Our team is coordinating with Fordham University and Library staff to see what the best way forward will be for our app to get access to the data. Do we create a Parse? Do we get IP Authentication? These issues are being worked out.

**DetailView**
- [ ] User sees the Detail View includes the image, name, description and, for some artifacts, audio

**SearchView**
- [ ] User sees Modal Search view controller that allows for search through all artifacts

**AudioView**
- [ ] User see Student Objects with transitions to audio files

**TwitterView**
- [x] Creation of @FordhamMuseum Twitter
- [ ] User sees a live feed of @FordhamMuseum tweets. We will need endpoints to authenticate and authorize @FordhamMuseum and will need to get the user, @FordhamMuseum's, tweets to display

## Optional User Stories
- [ ] Users of the App have the ability to login with their own twitter account and tweet @FordhamMuseum through the app

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/TGbQ0hU.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).


## Wireframe

<img src='http://i.imgur.com/xruVpZT.jpg' title='Wireframe' width='' alt='Wireframe' />
 
## License
      
          Copyright [2016] [Michael Gonzales, Michael Ceraso, Aaron Laub]
	  
	      Licensed under the Apache License, Version 2.0 (the "License");
	          you may not use this file except in compliance with the License.
		      You may obtain a copy of the License at
		      
		              http://www.apache.org/licenses/LICENSE-2.0
			      
			          Unless required by applicable law or agreed to in writing, software
				      distributed under the License is distributed on an "AS IS" BASIS,
				          WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
					      See the License for the specific language governing permissions and
					          limitations under the License.### Basic Yelp client
