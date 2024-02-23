enum CreateTimerFormField {
  project("Project"), task("Task"), description("Description"), favorite("Make Favorite");

  final String name;
  const CreateTimerFormField(this.name);
}