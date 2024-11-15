# Scaling in the Cloud

## Loosely coupled Architecture -> allows componenents to work independently and require little to no knowledge of the inner workings of the other components
- provides layer of abstraction
- gives flexibility in adding new functionality or changing existing functionality
- allows for changeable components, atomic functional units, and scale components indendepently

## Scaling Up vs. Scaling Out
| Scaling Up | Scaling Out |
|:--------------:|:-----------------:|
|aka Vertical Scale | aka Horizontal Scale |
| Add more CPU or RAM to an existing instance as demand increases | Add more instances as demand increases |
| Requires restart to scale up or down | No downtime required |
| Would require scripting to automate | Automate scaling available for compute services |
| Limited by instance sizes | Theoretically unlimited scaling potential |

## Knowing How to Scale
1. Are you using the appropriate service?
    - consider which services will meet compute and scaling needs
    - consider cost of service
    - consider operational overhead
2. Are you scaling with the appropriate metric?
    - choose metric that will most effectively scale our architecture to meet our needs
    - choose whether to optimize for cost or performance 

## Event-Driven Architecture -> a form of loosely coupled architecture that involves event producers sending events to event routers and those router sending events to event consumers
ex. lambda function sends an event to an event bridge which triggers a different lambda function.
These environments can get very complex and events can be sent and received asynchronously. This can only be achieved if our components are independently scalable and atomic in nature.

