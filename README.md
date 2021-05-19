# arith

## Build
 - You use a local libray yapb-0.1.2.
 - To do this, you should clone yapb into a sibling direction.

## Build for commit 4b9eabe, 

 - You use a Hackage libray yapb-0.1.1. To do this, you need to change package.yaml and stack.yaml.
 - You should delete yapb >= 0.1.1 in the dependencies in package.yaml.
 - You should add yapb >= 0.1.1 in the arith-exe of executables in package.yaml.
 - You should delete extra-deps and ../yapb in stack.yaml.

