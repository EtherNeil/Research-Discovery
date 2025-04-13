# Research Discovery Lab – Offline-First POS With Bayesian Conflict Resolution

This mini-project was conducted as part of my **IDIA4** training at **Polytech Nantes**.  
It provides a **literature review** (*état de l’art*) on an **offline-first architecture** for Point of Sale (POS) systems, combined with a **Bayesian network** for detecting and resolving conflicts (and potential fraud) during data synchronization.

## Context

In many commercial environments, network connectivity cannot be guaranteed at all times. POS terminals must therefore function offline and locally store their data (sales, stock updates, etc.). When connectivity is restored, **synchronizing** these offline databases can cause conflicts (e.g., two terminals selling the same item simultaneously). The idea here is to introduce a **Bayesian network** to distinguish a “natural” concurrent update from a potentially fraudulent or abnormal transaction once data is reintegrated.

## Objectives

1. **Search, select, and read relevant scientific articles**  
   - Explore academic sources (IEEE, ACM, Google Scholar, etc.)  
   - Understand existing work on offline-first POS, data synchronization, and Bayesian-based conflict detection.

2. **Compose a concise state-of-the-art (about 3 pages)**  
   - Provide a structured and critical overview of the topic:  
     - Introduction  
     - Thematic sections (synchronization offline-first, conflict resolution, security/fraud detection)  
     - Conclusion  
   - Integrate approximately 4–5 references if it’s tied to the final-year project theme.

3. **Include a reflective segment on the use of Generative AI**  
   - Per the teacher’s guidelines, **explain how** generative AI (LLM) assisted in the writing process and reference management.  
   - Critically discuss how you **verified** and **adapted** AI-generated outputs.

4. **Demonstrate your own approach**  
   - Illustrate how a Bayesian network can help classify conflicts (legitimate vs. suspicious).  
   - Discuss the potential impact on reducing fraud or data inconsistencies in an offline-first POS environment.

## Use of AI

Consistent with the professor’s requirement, we have **heavily leveraged AI** (a Large Language Model) to help:  

- Identify relevant literature more efficiently.  
- Propose an initial structuring of sections.  
- Generate text which was then **verified and edited** by a human for correctness, clarity, and scientific rigor.  

This **hybrid approach** highlights the **strength** of LLMs for speeding up academic work, combined with **manual quality control** to ensure reliable output.

## Technologies Used

- **Typst** for authoring the literature review (short scientific paper).  
