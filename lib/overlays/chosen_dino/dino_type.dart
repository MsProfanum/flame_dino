enum DinoType {
  dinoClassic(('assets/images/dino_classic.png', 'Dino', 0)),
  dinoDad(('assets/images/dino_dad.png', 'Dino Dad', 100)),
  dinoMum(('assets/images/dino_mum.png', 'Dino Mum', 300)),
  dinoChild(('assets/images/dino_child.png', 'Dino Child', 600)),
  dinoEgg(('assets/images/dino_egg.png', 'Dino Egg', 1000));

  final (String, String, int) data;
  const DinoType(this.data);
}
