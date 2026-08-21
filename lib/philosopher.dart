class PhilosopherQuote {
  final String quote;
  final String author;
  final String school;
  final String imageName;

  PhilosopherQuote({
    required this.quote,
    required this.author,
    required this.school,
    required this.imageName,
  });
}

final List<PhilosopherQuote> sampleQuotes = [
  PhilosopherQuote(
    quote: "The unexamined life is not worth living.",
    author: "Socrates",
    school: "Classical Greek",
    imageName: "socrates",
  ),
  PhilosopherQuote(
    quote: "He who has a why to live can bear almost any how.",
    author: "Friedrich Nietzsche",
    school: "Existentialism",
    imageName: "nietzsche",
  ),
  PhilosopherQuote(
    quote: "We suffer more often in imagination than in reality.",
    author: "Seneca",
    school: "Stoicism",
    imageName: "seneca",
  ),
];