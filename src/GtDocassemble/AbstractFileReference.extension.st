Extension { #name : #AbstractFileReference }

{ #category : #'*GtDocassemble' }
AbstractFileReference >> gtDocAssembleActionFor: anAction [
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
AbstractFileReference >> gtDocAssembleFor: aView [
	<gtView>
	| aYamlView sections |
	self flag: #TODO.	"Clarify if all yml files are under 'questions' folder, if not use more complex logic."
	self parent basename = 'questions' ifFalse: [ ^ aView empty ].	"or: [self withParents allButFirst anySatisfy: #isDocAssembleFolder]"
	aYamlView := (YAMLParser parse: self contents) object.
	sections := #('include' 'imports' 'metadata' 'code' 'question' 'objects' 'features' 'sections' 'attachment')
			collect: [ :each | each -> (aYamlView select: [ :aDocument | aDocument keys includes: each ]) ].
	self flag: #BUG."YAML parser seems to have some issues?!?"
	(sections detect: [ :each | each key = 'code' ]) value 
		do: [ :each | each at: 'code' put: (GtDocassembleCodeDocument withCode: (each at: 'code')) ].
	^ aView forward
		title: 'Docassemble Yaml';
		priority: 1;
		object: [ sections asDictionary ]
]
