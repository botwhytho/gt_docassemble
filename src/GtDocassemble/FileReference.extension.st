Extension { #name : #FileReference }

{ #category : #'*GtDocassemble' }
FileReference >> isDocAssembleFolder [
	^ self isDirectory
		and: [ #('docassemble' "'.git'") allSatisfy: [ :each | (self / each) exists ]]
]
