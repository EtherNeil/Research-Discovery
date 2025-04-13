# Research Discovery Lab – Offline-First POS With Bayesian Conflict Resolution

This mini-project was conducted as part of my **IDIA4** training at **Polytech Nantes**.  
It provides a **literature review** (*état de l’art*) on an **offline-first architecture** for Point of Sale (POS) systems, combined with a **Bayesian network** for detecting and resolving conflicts (and potential fraud) during data synchronization.

## Context

In many commercial environments, network connectivity cannot be guaranteed at all times. POS terminals must therefore function offline and locally store their data (sales, stock updates, etc.). When connectivity is restored, **synchronizing** these offline databases can cause conflicts (e.g., two terminals selling the same item simultaneously). The idea here is to introduce a **Bayesian network** to distinguish a “natural” concurrent update from a potentially fraudulent or abnormal transaction once data is reintegrated.

## Objectives

1. **Search, select, and read relevant scientific articles**  
   - Explore academic sources (ResearchGate, ...)  
   - Understand existing work on the topic

2. **Compose a concise state-of-the-art (about 3 pages)**  
   - Provide a structured and critical overview of the topic:  
     - Introduction  
     - Thematic sections
     - Conclusion  
   - Integrate approximately 4–5 references if it’s tied to the final-year project theme.

3. **Include a reflective segment on the use of Generative AI**  
   - Per the teacher’s guidelines, **explain how** generative AI (LLM) assisted in the writing process and reference management.  
   - Critically discuss how you **verified** and **adapted** AI-generated outputs.

## Technologies Used

- **Typst** for authoring the literature review (short scientific paper).  
