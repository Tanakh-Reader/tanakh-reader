## 1. Summary of the Old Advice

**High-level game plan**  
- **UX first**: Sketch clean, minimal reading flows before coding.  
- **MVVM architecture**:  
  - **Models** → your data classes (Word, Lexeme, Passage…)  
  - **ViewModels** → business logic, expose data to the UI  
  - **Views** → Flutter widgets/screens  
- **Tech stack**:  
  - **Firebase** – Auth + Firestore (live text + user data)  
  - **Hive** – local cache/offline  
  - **Riverpod** – state management  
- **Performance**: smooth scrolling, efficient search/filter algorithms  
- **User features**: track reading progress, save favorites, spaced-repetition vocab  
- **Testing**: unit, integration, end-to-end; catch bugs early  
- **Iterate**: ship a beta, gather feedback, refine  

**Repo structure**  
```
/
├─ assets/          # images, fonts, static data
├─ lib/
│  ├─ models/       # data classes
│  ├─ services/     # Firebase, local DB helpers, APIs
│  ├─ providers/    # Riverpod providers
│  ├─ viewmodels/   # MVVM logic
│  ├─ views/        # screens & layouts
│  ├─ widgets/      # reusable UI pieces
│  └─ utils/        # helpers, constants
├─ test/            # mirror lib/ structure for tests
└─ docs/            # any design or API docs
```

**DB organization**  
- Don’t mix Firestore + SQLite calls in one provider  
- Define a `BibleRepository` interface, with `FirestoreBibleRepo` & `SqlBibleRepo` implementations  
- If you ever need to combine sources, write a dedicated “aggregator” service  