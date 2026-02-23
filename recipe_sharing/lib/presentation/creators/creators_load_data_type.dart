enum CreatorsLoadDataType {
  all(displayName: 'Creators'),
  follows(displayName: "Follows");

  final String displayName;

  const CreatorsLoadDataType({required this.displayName});
}
