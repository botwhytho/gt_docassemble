Extension { #name : #FileReference }

{ #category : #'*GtDocassemble' }
FileReference >> gtDocAssembleActionFor: anAction [
	<gtAction>
	self isDocAssembleFolder
		ifFalse: [ ^ anAction noAction ]
		ifTrue: [ ^ anAction button
				tooltip: 'Docassemble Analysis';
				priority: -1;
				label: 'Docassemble';
				action: [ :aButton | aButton phlow spawnObject: (GtDocassemble inFolder: self) ] ]
]

{ #category : #'*GtDocassemble' }
FileReference >> gtDocAssembleFor: aView [
	<gtView>
	| aYamlView |
	(self parent basename = 'questions' "or: [self withParents allButFirst anySatisfy: #isDocAssembleFolder]")
		ifFalse: [ ^ aView empty ].
	aYamlView := (YAMLParser parse: self contents) object.
	^ aView forward
		title: 'Docassemble Yaml';
		priority: 1;
		object: [ (#('include' 'imports' 'metadata' 'code' 'question' 'objects' 'features' 'sections' 'attachment')
				collect: [ :each | each -> (aYamlView select: [ :aDocument | aDocument keys includes: each ]) ])
				asDictionary ]
]

{ #category : #'*GtDocassemble' }
FileReference >> isDocAssembleFolder [
	^ self isDirectory
		and: [ #('docassemble' "'.git'") allSatisfy: [ :each | (self / each) exists ]]
]
