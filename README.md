# witchy-run 🧹🧙‍♀️

**witchy-run** é a versão em **Godot Engine 4 (GDScript)** do jogo da bruxinha (*Endless Runner 2D*), desenvolvida originalmente em **Novembro de 2024** por **Mailson Maia Alves** para explorar os nós 2D do Godot 4 (`CharacterBody2D`, `Area2D`, `AnimatedSprite2D`), sinais e física GDScript.

> 💬 **Nota do Desenvolvedor:**  
> *"Ao revisitar este projeto da Godot em 2026, realizei apenas pequenas correções nos scripts GDScript e na organização da documentação. Vale ressaltar que este repositório foi construído originalmente em 2024 apenas para fins de estudo e aprendizado da engine Godot 4, e não como um produto comercial completo."*

---

## 📜 Histórico de Aprendizado & Recursos Explorados (2024)

Este projeto foi construído na **Godot Engine 4.x** utilizando GDScript:

1. **Movimentação e Pulo Duplo (`Scripts/player.gd`):**  
   Física 2D controlada via `CharacterBody2D`, aplicando gravidade (`gravity = 980`), movimento lateral `SPEED = 200` e controle de pulo duplo com a flag `can_double_jump`.
2. **Ciclo de Inimigos & Respawn (`Scripts/gotinha.gd`):**  
   Controle de deslocamento horizontal e temporizador aleatório (`Timer`) para reaparecimento das gotas de obstáculo.
3. **Coletáveis & Pontuação (`Scripts/item.gd`):**  
   Uso de `Area2D` com detecção de sinal `_on_body_entered` para incrementar a pontuação e exibir no HUD.
4. **Cenários Parallax (`Scripts/BG.gd`):**  
   Rolagem contínua de planos de fundo utilizando os recursos nativos do Godot 4.

---

## 🛠️ Revisão de Manutenção (Agosto de 2026)

Em **14 de Agosto de 2026**, o repositório passou por uma revisão de manutenção e refatoração de código:

1. **Correção de Flip de Sprite (`player.gd`):** Corrigido o bug na orientação do sprite (`flip_h = false`) ao caminhar para a direita.
2. **Implementação de Dano e Invencibilidade:** Adicionado o método `recebe_dano()` no jogador com redução de vidas, efeito de transparência no sprite durante o período de graça e recarga de cena no Game Over.
3. **Checagem Segura de Sinais & Métodos (`gotinha.gd`):** Adicionada verificação com `body.has_method("recebe_dano")` para evitar exceções em runtime ao interagir com o jogador.

---

## 📁 Estrutura do Projeto Godot 4

```text
witchy-run/
├── README.md                # Guia principal do repositório
├── CLAUDE.md                # Arquitetura e documentação técnica do Godot 4
├── project.godot            # Arquivo de configuração do projeto Godot 4
├── Scripts/
│   ├── player.gd            # Lógica de física, pulo duplo, vidas e invencibilidade
│   ├── gotinha.gd           # Inimigo de solo com timer de respawn
│   ├── item.gd              # Item coletável Area2D e contador de pontuação
│   ├── BG.gd                # Rolagem de Parallax
│   └── level.gd             # Gerenciador de fase
├── cenas/                   # Cenas .tscn (player.tscn, level.tscn, gotinha.tscn, item.tscn)
├── Assets/                  # Spritesheets, arte de fundo e texturas 2D
└── sons/                    # Trilha sonora e efeitos de áudio em .mp3 / .wav
```

---

## 👤 Autor

* **Desenvolvedor:** Mailson Maia Alves  
* **GitHub:** [@mailsonm](https://github.com/mailsonm)
