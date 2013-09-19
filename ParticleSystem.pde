class ParticleSystem {
  ArrayList<Particle> particles;
  int genRate; //particle/second

  ParticleSystem() {
    switch (mode) {
      case 0:
      genRate = 10;
      break;
      case 1:
      genRate = 50;
      break;
      case 2:
      genRate = 1;
    }
    particles = new ArrayList<Particle>();
  }

  void spawParticles() {
    int numParticles = (int)(genRate * Math.random());
    for (int i = 0; i < numParticles; i++) {
      particles.add(new Particle());
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

