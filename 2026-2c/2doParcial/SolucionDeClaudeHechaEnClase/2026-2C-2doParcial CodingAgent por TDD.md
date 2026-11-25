# ISW1 – 2do Parcial 2026-2C – CodingAgent resuelto por TDD con el Cuis MCP Server

Fecha: 2026-11-24 / 2026-11-25
Imagen: `/Users/hernan/Documents/Cuis/Working/CuisUniversity7.9-8395-MCPServer.image`
Enunciado: `/Users/hernan/Documents/IngSoft1-Repos/parciales/2026-2c/2doParcial/ISW1 – 2do Parcial – Parte práctica_ CodingAgent.pdf`

---

## 1. Resultado

El ejercicio quedó resuelto por TDD en la categoría `2026-2C-2doParcial`, con un fileout por paso y la imagen grabada.

### Diseño

- `Tool`: nombre no vacío y una acción que recibe la respuesta del LLM (`executeWith:`).
- `ModelContextProtocolServer`: nombre no vacío, al menos una tool, nombres de tool únicos. Responde `qualifiedToolNames` (`Smalltalk/evaluate`) y ejecuta una tool por nombre. No usé `MCPServer` porque ya existe en la imagen (es el paquete del MCP server de Cuis).
- `CodingAgent`: dinero, servers con nombre único y un LLM. `prompt:` corre el agentic loop: verifica dinero, pregunta con prompt, contexto y nombres de tools, descuenta el costo, ejecuta las tools con la respuesta, concatena el prompt al contexto y repite con la respuesta hasta que el LLM dice parar.
- `LLMAdapter` con `CheapLLMAdapter`, `AffordableLLMAdapter` y `ExpensiveLLMAdapter`: cada uno traduce `prompt:context:tools:` y `shouldStopOn:` al protocolo de su LLM y contesta un `LLMResponse` (costo, respuesta, nombres de tools). El agente no sabe qué LLM usa.

### Pasos TDD y fileouts

Los fileouts están en `/Users/hernan/Documents/Cuis/Working-UserFiles/FileOuts/2026-2C-2doParcial-stepNN.st`.

| Paso | Test |
|---|---|
| 01–02 | Tool: nombre vacío falla; ejecuta su acción con la respuesta |
| 03–05 | Server: nombre vacío, sin tools, tools repetidas |
| 06–07 | Agente: servers repetidos; sin dinero no puede hacer prompt |
| 08–09 | Prompt que termina cobra su costo; loop ejecuta tools hasta parar |
| 10–12 | Varias tools de distintos servers; contexto entre loops; dinero agotado a mitad del loop |
| 13–14 | AffordableLLM y ExpensiveLLM a través de sus adapters |
| 15 | Refactorización tras correr las heurísticas del mentor |

Dos aclaraciones sobre el proceso:

- Los pasos 10 a 12 pasaron en verde de entrada porque la implementación del paso 9 ya los cubría; los dejé como tests que documentan el comportamiento.
- En el paso 8 usé `gather:`, que no existe en Cuis, así que el fileout `step08` quedó con esa versión rota; lo corregí con `inject:into:` y el `step09` ya está en verde.

Las heurísticas fijas del Smalltalk Mentor no reportan nada sobre las 11 clases. Los 20 tests (14 nuevos más los 6 de `LLMTest`) pasan y la imagen está grabada.

### Paquete

Cuis registra el paquete con el prefijo de la categoría, así que se llama `2026` y contiene la categoría `2026-2C-2doParcial`. Quedó grabado con la descripción `Solve the CodingAgent exam with TDD` en:

`/Users/hernan/Documents/Cuis/Working-UserFiles/FileOuts/2026-2C-2doParcial.pck.st`

---

## 2. Bitácora completa: pasos, tools ejecutadas y resultados

Convención: cada tool del Cuis MCP Server se nombra como aparece en el servidor (`evaluate`, `batch`, `define_methods`, etc.). Dentro de un `batch` los pasos corren en orden y el servidor contesta una línea por paso.

### 2.1 Pedido previo: `100 factorial`

| Tool | Argumento | Resultado |
|---|---|---|
| `evaluate` | `100 factorial` | `93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000` |

### 2.2 Lectura del enunciado y exploración de la imagen

| # | Tool | Argumento | Resultado |
|---|---|---|---|
| 1 | `Read` (PDF) | el enunciado | Tres páginas: configuración del agente (dinero, MCP servers, LLM), servers (nombre no vacío y único, tools no vacías), tools (nombre no vacío y único por server, reciben la respuesta del LLM), el agentic loop de 5 pasos, el contexto como concatenación de prompts, el formato `Server/tool,Server/tool` de los nombres de tools, y los tres LLMs simulados que no pueden modificarse. El código debe ir en `2026-2C-2doParcial`. |
| 2 | `classes_in_category` | `LLM` | `AffordableLLM`, `CheapLLM`, `ExpensiveLLM`, `LLM`, `LLMTest` |
| 3 | `classes_in_category` | `2026-2C-2doParcial` | vacía |
| 4 | `list_packages` | prefijo `2026` | existe un paquete `2026` sin cambios propios |
| 5 | `search_selectors` | `fileOutCategory` | `fileOutCategory:`, `fileOutCategory:on:`, … |
| 6 | `class_sources` | `LLM,CheapLLM,AffordableLLM,ExpensiveLLM,LLMTest` | Código completo de los LLMs. Resumen de los protocolos: |

Protocolos relevados de los LLMs:

- `CheapLLM`: `prompt: anArray` con `{prompt. contexto. tools}`; responde `Array with: costo with: respuesta with: tools`. Fin del loop: `stopsOn: anAnswer` (respuesta vacía). Costos: vocales del prompt × 0.01, consonantes del contexto × 0.005, tamaño del string de tools × 0.0025.
- `AffordableLLM`: `responseOf: aString` con prompt, contexto y tools separados por `newLine`; responde un `Dictionary` con `#cost`, `#answer`, `#tools`. Fin: `hasFinshed: anAnswer` (respuesta `'stop'`, con el typo del enunciado).
- `ExpensiveLLM`: `prompt:`, `context:`, `toolNames:` y luego `run`; se leen `nextPromptCost`, `nextPrompt`, `tools`. Fin: `hasToStopWith: anAnswer` (respuesta `nil`).
- Los tres validan que las tools que devuelven estén incluidas en el string de tools configuradas.

| # | Tool | Argumento | Resultado |
|---|---|---|---|
| 7 | `package_of_class` | `LLM` | `LLM` |
| 8 | `evaluate` | fuente de `SystemOrganizer>>fileOutCategory:` y categorías `*2026*` | `fileOutCategory:` escribe en el directorio de fileouts del usuario vía `DirectoryEntry fileOutsDirQuery:writeStreamDo:`; no hay categorías con `2026`; `dollar` es un `BaseUnit` de Aconcagua |
| 9 | `classes_in_category` | `IS2c2026`, `2026`, `peep`, `IS` | vacías salvo `peep` (`Pepe`) — restos de otros trabajos, no se tocaron |
| 10 | `evaluate` | nombres de clase libres y pruebas de API | `Tool`, `CodingAgent`, `LLMResponse`, `LLMAdapter`, `CheapLLMAdapter`, `AffordableLLMAdapter`, `ExpensiveLLMAdapter`, `ModelContextProtocolServer` están libres. `'' substringsSeparatedBy: $,` responde `#('')` (hay que tratar el string vacío aparte). `(10*dollar) - (0.5*dollar)` → `9.5 * dollar`. `(0.0005*dollar) abs < (0.001*dollar)` → `true`. |
| 11 | `evaluate` | verificación del mecanismo de fileout | `fileOutSystemCategory:on:` existe; el directorio es `/Users/hernan/Documents/Cuis/Working-UserFiles/FileOuts`; `FileEntry>>forceWriteStreamDo:` y `DirectoryEntry>>assureExistence` existen; `'Smalltalk/evaluate' substringsSeparatedBy: $/` → `#('Smalltalk' 'evaluate')` |

Decisión sobre los fileouts: en vez de `SystemOrganization fileOutCategory:` (que pisa siempre el mismo archivo y puede preguntar por consola), cada paso escribe un archivo numerado con:

```smalltalk
((DirectoryEntry userBaseDirectory / 'FileOuts') // '2026-2C-2doParcial-stepNN.st')
    forceWriteStreamDo: [ :aStream |
        SystemOrganization fileOutSystemCategory: '2026-2C-2doParcial' on: aStream ]
```

### 2.3 Paso 1 — Tool: el nombre no puede ser vacío

`batch` de 7 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_class` | `TestCase subclass: #ToolTest` en `2026-2C-2doParcial` | definida |
| 2 | `define_methods` | `ToolTest>>test01ToolNameCannotBeEmpty` (`should:raise:withMessageText:` con `Tool named: '' doing: [:anAnswer | ]`) | definido |
| 3 | `run_test_class` | `ToolTest` | **rojo**: 0 pasan, 1 error (no existe `Tool`) |
| 4 | `define_class` | `Object subclass: #Tool` con `name action` | definida |
| 5 | `define_methods` | `Tool class>>named:doing:` (funnel con precondición), `Tool class>>assertIsNotEmpty:`, `Tool class>>nameCannotBeEmptyErrorDescription`, `Tool>>initializeNamed:doing:` | 4 definidos |
| 6 | `run_test_class` | `ToolTest` | **verde**: 1 pasa |
| 7 | `evaluate` | fileout | `step01 filed out` |

### 2.4 Pasos 2 y 3 — Tool ejecuta su acción; server con nombre vacío

`batch` de 12 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_methods` | `ToolTest>>test02ToolExecutesItsActionWithAnswer` | definido |
| 2 | `run_test_class` | `ToolTest` | **rojo**: 1 pasa, 1 error (`executeWith:` no existe) |
| 3 | `define_methods` | `Tool>>executeWith: anAnswer` → `^action value: anAnswer` | definido |
| 4 | `run_test_class` | `ToolTest` | **verde**: 2 pasan |
| 5 | `evaluate` | fileout | `step02 filed out` |
| 6 | `define_class` | `TestCase subclass: #ModelContextProtocolServerTest` | definida |
| 7 | `define_methods` | `test01ServerNameCannotBeEmpty` y el helper `evaluateTool` | definidos |
| 8 | `run_test_class` | `ModelContextProtocolServerTest` | **rojo**: 1 error (no existe la clase) |
| 9 | `define_class` | `Object subclass: #ModelContextProtocolServer` con `name tools` | definida |
| 10 | `define_methods` | `named:tools:` (funnel), `assertIsNotEmpty:`, `nameCannotBeEmptyErrorDescription`, `initializeNamed:tools:` | 4 definidos |
| 11 | `run_test_class` | `ModelContextProtocolServerTest` | **verde**: 1 pasa |
| 12 | `evaluate` | fileout | `step03 filed out` |

### 2.5 Pasos 4 y 5 — server sin tools; tools con nombre repetido

`batch` de 10 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_methods` | `test02ServerMustHaveTools` (tools `#()`) | definido |
| 2 | `run_test_class` | | **rojo**: 1 pasa, 1 error |
| 3 | `define_methods` | `named:tools:` ahora envía `assertHasTools:`; `assertHasTools:` (`ifEmpty:`); `toolsCannotBeEmptyErrorDescription` | 3 definidos |
| 4 | `run_test_class` | | **verde**: 2 pasan |
| 5 | `evaluate` | fileout | `step04 filed out` |
| 6 | `define_methods` | `test03ToolNamesMustBeUniqueInServer` (dos tools `evaluate`) | definido |
| 7 | `run_test_class` | | **rojo**: 2 pasan, 1 error |
| 8 | `define_methods` | `named:tools:` envía `assertNamesAreUniqueIn:`; `assertNamesAreUniqueIn:` (`collect:` de nombres, `asSet size = size`); `toolNamesMustBeUniqueErrorDescription`; `Tool>>name` (reimplementado porque `Object>>name` ya existe) | 4 definidos |
| 9 | `run_test_class` | | **verde**: 3 pasan |
| 10 | `evaluate` | fileout | `step05 filed out` |

### 2.6 Pasos 6 y 7 — agente: servers con nombre único; sin dinero no se puede hacer prompt

`batch` de 12 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_class` | `TestCase subclass: #CodingAgentTest` con `evaluatedAnswers createdFiles` | definida |
| 2 | `define_methods` | `setUp`, `smalltalkServer` (server `Smalltalk` con tool `evaluate` que agrega la respuesta a `evaluatedAnswers`), `cheapLLMEndingImmediately` (por ahora un `CheapLLM` crudo, no se usa en estos tests), `test01ServerNamesMustBeUniqueInAgent` | 4 definidos |
| 3 | `run_test_class` | `CodingAgentTest` | **rojo**: 1 error (no existe `CodingAgent`) |
| 4 | `define_class` | `Object subclass: #CodingAgent` con `availableMoney servers llm context` | definida |
| 5 | `define_methods` | `CodingAgent class>>availableMoney:servers:llm:` (funnel), `assertNamesAreUniqueIn:`, `serverNamesMustBeUniqueErrorDescription`, `initializeAvailableMoney:servers:llm:` (contexto inicial `''`), `ModelContextProtocolServer>>name` | 5 definidos |
| 6 | `run_test_class` | | **verde**: 1 pasa |
| 7 | `evaluate` | fileout | `step06 filed out` |
| 8 | `define_methods` | helper `agentWith:using:`; `test02AgentWithoutMoneyCannotPrompt` (agente con `0*dollar`, `prompt:` debe fallar, el dinero sigue en 0 y no se ejecutó ninguna tool) | 2 definidos |
| 9 | `run_test_class` | | **rojo**: 1 pasa, 1 error |
| 10 | `define_methods` | `noMoneyAvailableErrorDescription`, `prompt:` (solo `self assertHasMoneyAvailable`), `assertHasMoneyAvailable` (`availableMoney <= (0*dollar)`), `availableMoney` | 4 definidos |
| 11 | `run_test_class` | | **verde**: 2 pasan |
| 12 | `evaluate` | fileout | `step07 filed out` |

### 2.7 Pasos 8 y 9 — el prompt cobra su costo; el loop ejecuta las tools hasta que el LLM para

`batch` de 13 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_methods` | `cheapLLMEndingImmediately` ahora envuelve con `CheapLLMAdapter on:`; helpers `costOf:prompting:withContext:tools:` y `assert:isCloseTo:` (`(a - b) abs < (0.001*dollar)`); `test03PromptEndingImmediatelyChargesItsCostAndExecutesNoTool` | 4 definidos |
| 2 | `run_test_class` | | **rojo**: test01 falla y test02/test03 dan error (no existe `CheapLLMAdapter`) |
| 3–5 | `define_class` ×3 | `LLMResponse` (`cost answer toolNames`), `LLMAdapter` (`llm`), `CheapLLMAdapter` | definidas |
| 6 | `define_methods` | `LLMResponse class>>cost:answer:toolNames:`, `initializeCost:answer:toolNames:`, accessors `cost`/`answer`/`toolNames`; `LLMAdapter class>>on:`, `initializeOn:`, `prompt:context:tools:` y `shouldStopOn:` como `subclassResponsibility`; `CheapLLMAdapter>>prompt:context:tools:` (arma el `Array` y traduce la respuesta) y `shouldStopOn:` (`llm stopsOn:`); `CodingAgent>>prompt:` (un ciclo), `runCycleWith:` (verifica dinero, pregunta, descuenta costo, ejecuta tools, concatena el prompt al contexto), `toolNames` (streamContents con `do:separatedBy:` sobre `gather:`), `executeToolsNamed:with:` (solo el guard `ifEmpty:`); `ModelContextProtocolServer>>qualifiedToolNames` | 16 definidos |
| 7 | `run_test_class` | | 2 pasan, **test03 sigue en error** |
| 8 | `evaluate` | fileout | `step08 filed out` (con el código roto, ver abajo) |
| 9 | `define_methods` | `test04ToolsAnsweredByLLMAreExecutedWithItsAnswerUntilItStops` (`CheapLLM` responde `'continue'` con `Smalltalk/evaluate` y luego `''`; se espera `evaluatedAnswers = #('continue')` y el costo de dos ciclos) | definido |
| 10 | `run_test_class` | | **rojo**: test03 y test04 en error |
| 11 | `define_methods` | `prompt:` con el loop `[ llm shouldStopOn: response answer ] whileFalse:`; `executeToolsNamed:with:` separa por `$,`; `executeToolNamed:with:` separa server y tool con un `readStream upTo: $/`; `serverNamed:`; `ModelContextProtocolServer>>executeToolNamed:with:` y `toolNamed:` | 6 definidos |
| 12 | `run_test_class` | | **sigue rojo**: test03 y test04 en error |
| 13 | `evaluate` | fileout | `step09 filed out` (todavía roto) |

Diagnóstico del error:

| Tool | Argumento | Resultado |
|---|---|---|
| `evaluate` | correr `test03` bajo `on: Error do:` y mostrar `messageText` y `signalerContext` | `Array>>gather: @ Array(Object)>>doesNotUnderstand: #gather:` |
| `search_selectors` | `flatCollect*;gather*;flatten*;addAllFirst` | aparece `gather:` como selector pero… |
| `implementors_of` | `gather:,flatten` | `gather:` no tiene implementadores; `flatten` lo implementa `Collection` |
| `method_sources` | `Collection>>flatten` | usa `species streamContents:` y `flattenTo:`; aplanaría también los strings, así que no sirve |

Corrección, `batch` de 3 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_methods` | `toolNames` usa `self qualifiedToolNames`; `qualifiedToolNames` = `servers inject: #() into: [...]` concatenando los nombres calificados de cada server | 2 definidos |
| 2 | `run_test_class` | `CodingAgentTest` | **verde**: 4 pasan |
| 3 | `evaluate` | fileout | `step09 filed out` (rehecho, en verde) |

### 2.8 Pasos 10, 11 y 12 — varias tools, contexto entre loops, dinero agotado

`batch` de 9 pasos. Los tres tests pasaron de entrada porque la implementación del paso 9 ya era general; quedan como tests que documentan el comportamiento.

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_methods` | helper `fileSystemServer` (server `FileSystem` con tool `createFile` que agrega a `createdFiles`); `test05SeveralToolsOfDifferentServersAnsweredByLLMAreAllExecuted` (el LLM responde `'Smalltalk/evaluate,FileSystem/createFile'`; ambas tools se ejecutan con `'continue'`; el costo usa el string completo de tools, lo que verifica el formato `Server/tool,Server/tool`) | 2 definidos |
| 2 | `run_test_class` | | **verde**: 5 pasan |
| 3 | `evaluate` | fileout | `step10 filed out` |
| 4 | `define_methods` | `test06ContextKeepsPromptsOfPreviousLoops` (`prompt: 'hello'` y luego `prompt: 'bye'`; el segundo se cobra con contexto `'hello'`) | definido |
| 5 | `run_test_class` | | **verde**: 6 pasan |
| 6 | `evaluate` | fileout | `step11 filed out` |
| 7 | `define_methods` | `test07LoopCannotContinueWhenMoneyRunsOut` (agente con `0.01*dollar`; el primer ciclo se cobra y ejecuta `evaluate` con `'continue'`; el segundo ciclo falla con `noMoneyAvailableErrorDescription`; el dinero queda negativo) | definido |
| 8 | `run_test_class` | | **verde**: 7 pasan |
| 9 | `evaluate` | fileout | `step12 filed out` |

### 2.9 Pasos 13 y 14 — AffordableLLM y ExpensiveLLM

`batch` de 13 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_methods` | `test08AffordableLLMIsPromptedLikeAnyOtherLLM` (`'continue'` y luego `'stop'`) | definido |
| 2 | `run_test_class` | | **rojo**: 7 pasan, 1 error (no existe `AffordableLLMAdapter`) |
| 3 | `define_class` | `LLMAdapter subclass: #AffordableLLMAdapter` | definida |
| 4 | `define_methods` | `prompt:context:tools:` (arma el query con `newLine` y traduce el `Dictionary`), `queryFor:context:tools:`, `shouldStopOn:` (`llm hasFinshed:`) | 3 definidos |
| 5 | `run_test_class` | | **verde**: 8 pasan |
| 6 | `evaluate` | fileout | `step13 filed out` |
| 7 | `define_methods` | `test09ExpensiveLLMIsPromptedLikeAnyOtherLLM` (`'continue'` y luego `nil`) | definido |
| 8 | `run_test_class` | | **rojo**: 8 pasan, 1 error |
| 9 | `define_class` | `LLMAdapter subclass: #ExpensiveLLMAdapter` | definida |
| 10 | `define_methods` | `prompt:context:tools:` (cascada `prompt:; context:; toolNames:; run` y lectura de `nextPromptCost`, `nextPrompt`, `tools`), `shouldStopOn:` (`llm hasToStopWith:`) | 2 definidos |
| 11 | `run_test_class` | | **verde**: 9 pasan |
| 12 | `evaluate` | fileout | `step14 filed out` |
| 13 | `run_tests_in_categories` | `2026-2C-2doParcial,LLM` | **20 pasan**, 0 fallan, 0 errores |

### 2.10 Heurísticas del Smalltalk Mentor

Cómo se corrieron sin abrir la ventana del mentor:

| Tool | Argumento | Resultado |
|---|---|---|
| `classes_in_category` | `SmalltalkMentor` | lista de las clases de heurísticas y de `SmalltalkMentorClassCategoryReview` |
| `search_selectors` | `*fixedHeuristic*;*reviewClass*;*findingsOf*` | `reviewClass:selector:`, … |
| `method_sources_of_class` | `SmalltalkMentorClassCategoryReview class`, `SmalltalkMentorClassCategoryReview`, `SmalltalkMentorReview` | `SmalltalkMentorReview>>classHeuristicsFor:` y `methodHeuristicsFor:` no dependen del mentor (LLM), así que se pueden correr con `SmalltalkMentorClassCategoryReview new`; `sideSummaryOf:` resume los métodos con hallazgos de un lado de clase |
| `evaluate` | para cada clase de la categoría: hallazgos de las heurísticas de clase y `sideSummaryOf:` de instancia y de clase | primer informe de hallazgos (abajo) |

Primer informe:

- `KeywordMessageSendFormatHeuristic` (envío keyword de más de 80 caracteres debe partirse con el receptor en una línea y un keyword por línea) en `CodingAgent>>prompt:`, `assertHasMoneyAvailable`, `qualifiedToolNames`, `executeToolNamed:with:`, `executeToolsNamed:with:`, los tres `prompt:context:tools:`, varios helpers y tests.
- `MoveHelperMethodToRightClassHeuristic` en `AffordableLLMAdapter>>queryFor:context:tools:` y `CodingAgentTest>>costOf:prompting:withContext:tools:` (no referencian `self` ni variables de instancia).
- `RepeatedClassWordHeuristic`: `CodingAgentTest>>agentWith:using:` repite `Agent`; la variable `llm` de `LLMAdapter` repite `LLM`.
- `NoEmptyMethodCategoriesHeuristic`: categoría `as yet unclassified` vacía del lado de clase de los tests y los adapters.
- `MethodComplexityHeuristic` (más de 10 envíos) en 8 tests de `CodingAgentTest`.

| Tool | Argumento | Resultado |
|---|---|---|
| `evaluate` | descripción de `KeywordMessageSendFormatHeuristic` y `failureRanges` de 7 métodos | confirmó que marca cada línea de envío keyword de más de 80 caracteres, incluso anidado |
| `ToolSearch` | cargar `refactor_rename_instance_variable` | cargada |

Primera corrección, `batch` de 8 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `refactor_rename_instance_variable` | `LLMAdapter` `llm` → `model` | 7 métodos cambiados (los tres adapters y `initializeOn:`) |
| 2 | `define_class` | `CodingAgentTest` agrega la variable `llm` (el LLM crudo del test, para calcular costos) | definida |
| 3 | `delete_methods` | `CodingAgentTest>>agentWith:using:` y `costOf:prompting:withContext:tools:` | borrados |
| 4 | `delete_methods` | `AffordableLLMAdapter>>queryFor:context:tools:` | borrado |
| 5 | `define_methods` | Reformateo de `CodingAgent>>prompt:`, `assertHasMoneyAvailable`, `qualifiedToolNames`, `executeToolsNamed:with:`, `executeToolNamed:with:` y de los tres `prompt:context:tools:` (el de Affordable con el query inline); tests del server reformateados; en `CodingAgentTest`: `initialMoney`, `evaluateTool`, `createFileTool`, `smalltalkToolNames`, `smalltalkServer`, `fileSystemServer`, `configuredWith:using:`, `configuredUsing:`, `costOfPrompting:withContext:`, `costOfPrompting:withContext:tools:` (usa la variable `llm`), `assert:spent:` y los 9 tests reescritos sobre esos helpers | 30 definidos |
| 6 | `evaluate` | `removeEmptyCategories` del lado de clase de todas las clases de la categoría | hecho |
| 7 | `run_tests_in_categories` | `2026-2C-2doParcial,LLM` | **20 pasan** |
| 8 | `evaluate` | segundo informe del mentor | quedan: categoría vacía `prompting - private` en `AffordableLLMAdapter` y complejidad en su `prompt:context:tools:`; formato en `CheapLLMAdapter>>prompt:context:tools:`, `costOfPrompting:withContext:` y `test03ToolNamesMustBeUniqueInServer`; complejidad en 7 tests |

| Tool | Argumento | Resultado |
|---|---|---|
| `method_sources_of_class` | `MethodComplexityHeuristic` | `fails` es `messageNodes size > 10` |

Segunda corrección, `batch` de 5 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_methods` | `CheapLLMAdapter>>prompt:context:tools:` partido; `AffordableLLMAdapter>>prompt:context:tools:` delega en `responseFor:context:tools:` (referencia `model`, así que ya no es un helper); `ModelContextProtocolServerTest>>toolsNamedAlike` y `test03` sobre él; en `CodingAgentTest`: `configuredWithBothServersUsing:`, `costOfPrompts:` y `costOfPrompts:tools:` (suma el costo de una secuencia de prompts acumulando el contexto), `assert:spent:from:`, `assert:spent:`, `assertEvaluated:`, `assertCreated:`, `assertNoToolWasExecuted`; tests 02 a 09 reescritos con arrays literales (`#('continue' '')`, `#('continue' nil)`) y esos helpers | 21 definidos |
| 2 | `delete_methods` | `CodingAgentTest>>costOfPrompting:withContext:` | borrado |
| 3 | `evaluate` | `removeEmptyCategories` de ambos lados de todas las clases | hecho |
| 4 | `run_tests_in_categories` | | **20 pasan** |
| 5 | `evaluate` | tercer informe | quedan: formato en `costOfPrompts:tools:` y en `test03ToolNamesMustBeUniqueInServer`; complejidad en `test07` (11 envíos) |

Tercera corrección, `batch` de 5 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `define_methods` | `costOfPrompts:tools:` con la suma partida en dos líneas; `test07` con una temporal `money` (10 envíos); `test03` del server con el envío partido en cuatro líneas | 3 definidos |
| 2 | `run_tests_in_categories` | | **20 pasan** |
| 3 | `evaluate` | cuarto informe | solo `test03ToolNamesMustBeUniqueInServer` (formato) |
| 4 | `evaluate` | fileout | `step15 filed out` |
| 5 | `save_image` | | imagen grabada |

| Tool | Argumento | Resultado |
|---|---|---|
| `evaluate` | `failureRanges` de `test03` | la línea `withMessageText: ModelContextProtocolServer toolNamesMustBeUniqueErrorDescription` tiene 81 caracteres por el largo del selector |
| `refactor_rename_selector` | `ModelContextProtocolServer class` `toolNamesMustBeUniqueErrorDescription` → `repeatedToolNameErrorDescription`, scope `category` | 3 métodos cambiados (`assertNamesAreUniqueIn:`, el nuevo selector y `test03`), 1 removido |

Cierre, `batch` de 4 pasos:

| # | Tool | Qué hizo | Resultado |
|---|---|---|---|
| 1 | `run_tests_in_categories` | `2026-2C-2doParcial,LLM` | **20 pasan**, 0 fallan, 0 errores |
| 2 | `evaluate` | informe final del mentor | **sin hallazgos** en las 11 clases |
| 3 | `evaluate` | fileout `step15` rehecho y listado del directorio | `2026-2C-2doParcial-step01.st` … `step15.st` (15 archivos) |
| 4 | `save_image` | | `/Users/hernan/Documents/Cuis/Working/CuisUniversity7.9-8395-MCPServer.image` |

### 2.11 Grabación del paquete (2026-11-25)

| # | Tool | Argumento | Resultado |
|---|---|---|---|
| 1 | `package_definition` | `2026-2C-2doParcial` | no existe con ese nombre |
| 2 | `unsaved_packages` | | `2026`, `IS`, `IS2c2026`, `LLM`, `ToolsTests`, `peep` |
| 3 | `package_definition` | `2026` | contiene la categoría `2026-2C-2doParcial` y las 11 clases; sin archivo asignado |
| 4 | `change_package_description` | `2026` → `Solve the CodingAgent exam with TDD` | cambiada |
| 5 | `save_package` | `2026` | error: el paquete no sabe a qué archivo escribirse |
| 6 | `change_package_file_name` | `/Users/hernan/Documents/Cuis/Working-UserFiles/FileOuts/2026-2C-2doParcial.pck.st` | asignado |
| 7 | `save_package` | `2026` | escrito en ese archivo |
| 8 | `unsaved_packages` | | `2026` ya no figura |
| 9 | `save_image` | | imagen grabada |

---

## 3. Código final

Es el contenido de `2026-2C-2doParcial-step15.st` (idéntico al del paquete salvo el header).

```smalltalk
!classDefinition: #CodingAgent category: #'2026-2C-2doParcial'!
Object subclass: #CodingAgent
	instanceVariableNames: 'availableMoney servers llm context'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgent methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
initializeAvailableMoney: aMoney servers: aServers llm: aLLM

	availableMoney := aMoney.
	servers := aServers.
	llm := aLLM.
	context := ''! !


!CodingAgent methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
prompt: aPrompt

	| response |

	response := self runCycleWith: aPrompt.
	[ llm shouldStopOn: response answer ]
		whileFalse: [ response := self runCycleWith: response answer ]! !


!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
assertHasMoneyAvailable

	availableMoney <= (0*dollar)
		ifTrue: [ self error: self class noMoneyAvailableErrorDescription ]! !

!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
qualifiedToolNames

	^servers
		inject: #()
		into: [ :toolNames :aServer | toolNames, aServer qualifiedToolNames ]! !

!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
runCycleWith: aPrompt

	| response |

	self assertHasMoneyAvailable.
	response := llm prompt: aPrompt context: context tools: self toolNames.
	availableMoney := availableMoney - response cost.
	self executeToolsNamed: response toolNames with: response answer.
	context := context, aPrompt.

	^response! !

!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:25:10 pm (UTC)'!
toolNames

	^String streamContents: [ :aStream |
		self qualifiedToolNames
			do: [ :aQualifiedToolName | aStream nextPutAll: aQualifiedToolName ]
			separatedBy: [ aStream nextPut: $, ] ]! !


!CodingAgent methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
availableMoney

	^availableMoney! !


!CodingAgent methodsFor: 'tools - private' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
executeToolNamed: aQualifiedToolName with: anAnswer

	| nameStream |

	nameStream := aQualifiedToolName readStream.
	(self serverNamed: (nameStream upTo: $/))
		executeToolNamed: nameStream upToEnd
		with: anAnswer! !

!CodingAgent methodsFor: 'tools - private' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
executeToolsNamed: aQualifiedToolNames with: anAnswer

	aQualifiedToolNames ifEmpty: [ ^self ].
	(aQualifiedToolNames substringsSeparatedBy: $,) do: [ :aQualifiedToolName |
		self executeToolNamed: aQualifiedToolName with: anAnswer ]! !

!CodingAgent methodsFor: 'tools - private' stamp: 'HAW 24/Nov/2026, 11:24:36 pm (UTC)'!
serverNamed: aName

	^servers detect: [ :aServer | aServer name = aName ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CodingAgent class' category: #'2026-2C-2doParcial'!
CodingAgent class
	instanceVariableNames: ''!

!CodingAgent class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
availableMoney: aMoney servers: aServers llm: aLLM

	self assertNamesAreUniqueIn: aServers.

	^self new initializeAvailableMoney: aMoney servers: aServers llm: aLLM! !


!CodingAgent class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
assertNamesAreUniqueIn: aServers

	(aServers collect: [ :aServer | aServer name ]) asSet size = aServers size
		ifFalse: [ self error: self serverNamesMustBeUniqueErrorDescription ]! !


!CodingAgent class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
noMoneyAvailableErrorDescription

	^'There is no money available to prompt the LLM'! !

!CodingAgent class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
serverNamesMustBeUniqueErrorDescription

	^'Server names must be unique in an agent'! !


!classDefinition: #LLMAdapter category: #'2026-2C-2doParcial'!
Object subclass: #LLMAdapter
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!LLMAdapter methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
initializeOn: aLLM

	model := aLLM! !


!LLMAdapter methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
prompt: aPrompt context: aContext tools: aToolNames

	self subclassResponsibility! !


!LLMAdapter methodsFor: 'testing for end' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
shouldStopOn: anAnswer

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LLMAdapter class' category: #'2026-2C-2doParcial'!
LLMAdapter class
	instanceVariableNames: ''!

!LLMAdapter class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
on: aLLM

	^self new initializeOn: aLLM! !


!classDefinition: #AffordableLLMAdapter category: #'2026-2C-2doParcial'!
LLMAdapter subclass: #AffordableLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!AffordableLLMAdapter methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
prompt: aPrompt context: aContext tools: aToolNames

	| response |

	response := self responseFor: aPrompt context: aContext tools: aToolNames.

	^LLMResponse
		cost: (response at: #cost)
		answer: (response at: #answer)
		toolNames: (response at: #tools)! !


!AffordableLLMAdapter methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
responseFor: aPrompt context: aContext tools: aToolNames

	^model responseOf: (String streamContents: [ :aStream |
		aStream
			nextPutAll: aPrompt; newLine;
			nextPutAll: aContext; newLine;
			nextPutAll: aToolNames; newLine ])! !


!AffordableLLMAdapter methodsFor: 'testing for end' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
shouldStopOn: anAnswer

	^model hasFinshed: anAnswer! !


!classDefinition: #CheapLLMAdapter category: #'2026-2C-2doParcial'!
LLMAdapter subclass: #CheapLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CheapLLMAdapter methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
prompt: aPrompt context: aContext tools: aToolNames

	| response |

	response := model
		prompt: (Array with: aPrompt with: aContext with: aToolNames).

	^LLMResponse
		cost: response first
		answer: response second
		toolNames: response third! !


!CheapLLMAdapter methodsFor: 'testing for end' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
shouldStopOn: anAnswer

	^model stopsOn: anAnswer! !


!classDefinition: #ExpensiveLLMAdapter category: #'2026-2C-2doParcial'!
LLMAdapter subclass: #ExpensiveLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ExpensiveLLMAdapter methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
prompt: aPrompt context: aContext tools: aToolNames

	model
		prompt: aPrompt;
		context: aContext;
		toolNames: aToolNames;
		run.

	^LLMResponse
		cost: model nextPromptCost
		answer: model nextPrompt
		toolNames: model tools! !


!ExpensiveLLMAdapter methodsFor: 'testing for end' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
shouldStopOn: anAnswer

	^model hasToStopWith: anAnswer! !


!classDefinition: #LLMResponse category: #'2026-2C-2doParcial'!
Object subclass: #LLMResponse
	instanceVariableNames: 'cost answer toolNames'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!LLMResponse methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
initializeCost: aCost answer: anAnswer toolNames: aToolNames

	cost := aCost.
	answer := anAnswer.
	toolNames := aToolNames! !


!LLMResponse methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
answer

	^answer! !

!LLMResponse methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
cost

	^cost! !

!LLMResponse methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
toolNames

	^toolNames! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LLMResponse class' category: #'2026-2C-2doParcial'!
LLMResponse class
	instanceVariableNames: ''!

!LLMResponse class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
cost: aCost answer: anAnswer toolNames: aToolNames

	^self new initializeCost: aCost answer: anAnswer toolNames: aToolNames! !


!classDefinition: #ModelContextProtocolServer category: #'2026-2C-2doParcial'!
Object subclass: #ModelContextProtocolServer
	instanceVariableNames: 'name tools'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ModelContextProtocolServer methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
initializeNamed: aName tools: aTools

	name := aName.
	tools := aTools! !


!ModelContextProtocolServer methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
name

	^name! !


!ModelContextProtocolServer methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:24:36 pm (UTC)'!
executeToolNamed: aName with: anAnswer

	^(self toolNamed: aName) executeWith: anAnswer! !

!ModelContextProtocolServer methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
qualifiedToolNames

	^tools collect: [ :aTool | name, '/', aTool name ]! !


!ModelContextProtocolServer methodsFor: 'tools - private' stamp: 'HAW 24/Nov/2026, 11:24:36 pm (UTC)'!
toolNamed: aName

	^tools detect: [ :aTool | aTool name = aName ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ModelContextProtocolServer class' category: #'2026-2C-2doParcial'!
ModelContextProtocolServer class
	instanceVariableNames: ''!

!ModelContextProtocolServer class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
named: aName tools: aTools

	self assertIsNotEmpty: aName.
	self assertHasTools: aTools.
	self assertNamesAreUniqueIn: aTools.

	^self new initializeNamed: aName tools: aTools! !


!ModelContextProtocolServer class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
assertHasTools: aTools

	aTools ifEmpty: [ self error: self toolsCannotBeEmptyErrorDescription ]! !

!ModelContextProtocolServer class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
assertIsNotEmpty: aName

	aName ifEmpty: [ self error: self nameCannotBeEmptyErrorDescription ]! !

!ModelContextProtocolServer class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:32:13 pm (UTC)'!
assertNamesAreUniqueIn: aTools

	(aTools collect: [ :aTool | aTool name ]) asSet size = aTools size
		ifFalse: [ self error: self repeatedToolNameErrorDescription ]! !


!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
nameCannotBeEmptyErrorDescription

	^'A server name cannot be empty'! !

!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:32:13 pm (UTC)'!
repeatedToolNameErrorDescription

	^'Tool names must be unique in a server'! !

!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
toolsCannotBeEmptyErrorDescription

	^'A server must have at least one tool'! !


!classDefinition: #Tool category: #'2026-2C-2doParcial'!
Object subclass: #Tool
	instanceVariableNames: 'name action'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!Tool methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
initializeNamed: aName doing: anAction

	name := aName.
	action := anAction! !


!Tool methodsFor: 'executing' stamp: 'HAW 24/Nov/2026, 11:22:12 pm (UTC)'!
executeWith: anAnswer

	^action value: anAnswer! !


!Tool methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tool class' category: #'2026-2C-2doParcial'!
Tool class
	instanceVariableNames: ''!

!Tool class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
named: aName doing: anAction

	self assertIsNotEmpty: aName.

	^self new initializeNamed: aName doing: anAction! !


!Tool class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
assertIsNotEmpty: aName

	aName ifEmpty: [ self error: self nameCannotBeEmptyErrorDescription ]! !


!Tool class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
nameCannotBeEmptyErrorDescription

	^'A tool name cannot be empty'! !


!classDefinition: #CodingAgentTest category: #'2026-2C-2doParcial'!
TestCase subclass: #CodingAgentTest
	instanceVariableNames: 'evaluatedAnswers createdFiles llm'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgentTest methodsFor: 'setup' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
setUp

	evaluatedAnswers := OrderedCollection new.
	createdFiles := OrderedCollection new! !


!CodingAgentTest methodsFor: 'servers' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
fileSystemServer

	^ModelContextProtocolServer
		named: 'FileSystem'
		tools: (Array with: self createFileTool)! !

!CodingAgentTest methodsFor: 'servers' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
smalltalkServer

	^ModelContextProtocolServer
		named: 'Smalltalk'
		tools: (Array with: self evaluateTool)! !


!CodingAgentTest methodsFor: 'llms' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
cheapLLMEndingImmediately

	^CheapLLMAdapter on: (CheapLLM answers: (Array with: ''))! !


!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
test01ServerNamesMustBeUniqueInAgent

	self
		should: [
			CodingAgent
				availableMoney: self initialMoney
				servers: (Array with: self smalltalkServer with: self smalltalkServer)
				llm: self cheapLLMEndingImmediately ]
		raise: Error
		withMessageText: CodingAgent serverNamesMustBeUniqueErrorDescription! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test02AgentWithoutMoneyCannotPrompt

	| agent |

	agent := self configuredWith: 0*dollar using: self cheapLLMEndingImmediately.

	self
		should: [ agent prompt: 'hello' ]
		raise: Error
		withMessageText: CodingAgent noMoneyAvailableErrorDescription.
	self assert: agent availableMoney equals: 0*dollar.
	self assertNoToolWasExecuted! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test03PromptEndingImmediatelyChargesItsCostAndExecutesNoTool

	| agent |

	llm := CheapLLM answers: #('').
	agent := self configuredUsing: (CheapLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assert: agent spent: (self costOfPrompts: #('hello')).
	self assertNoToolWasExecuted! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test04ToolsAnsweredByLLMAreExecutedWithItsAnswerUntilItStops

	| agent |

	llm := CheapLLM answers: #('continue' '') toolsToExecute: #('Smalltalk/evaluate' '').
	agent := self configuredUsing: (CheapLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assertEvaluated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello' 'continue'))! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test05SeveralToolsOfDifferentServersAnsweredByLLMAreAllExecuted

	| agent toolNames |

	toolNames := 'Smalltalk/evaluate,FileSystem/createFile'.
	llm := CheapLLM answers: #('continue' '') toolsToExecute: (Array with: toolNames with: '').
	agent := self configuredWithBothServersUsing: (CheapLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assertEvaluated: #('continue').
	self assertCreated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello' 'continue') tools: toolNames)! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test06ContextKeepsPromptsOfPreviousLoops

	| agent |

	llm := CheapLLM answers: #('' '').
	agent := self configuredUsing: (CheapLLMAdapter on: llm).

	agent prompt: 'hello'.
	agent prompt: 'bye'.

	self assertNoToolWasExecuted.
	self assert: agent spent: (self costOfPrompts: #('hello' 'bye'))! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:54 pm (UTC)'!
test07LoopCannotContinueWhenMoneyRunsOut

	| agent money |

	money := 0.01*dollar.
	llm := CheapLLM answers: #('continue' '') toolsToExecute: #('Smalltalk/evaluate' '').
	agent := self configuredWith: money using: (CheapLLMAdapter on: llm).

	self
		should: [ agent prompt: 'hello' ]
		raise: Error
		withMessageText: CodingAgent noMoneyAvailableErrorDescription.
	self assertEvaluated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello')) from: money! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test08AffordableLLMIsPromptedLikeAnyOtherLLM

	| agent |

	llm := AffordableLLM answers: #('continue' 'stop') toolsToExecute: #('Smalltalk/evaluate' '').
	agent := self configuredUsing: (AffordableLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assertEvaluated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello' 'continue'))! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test09ExpensiveLLMIsPromptedLikeAnyOtherLLM

	| agent |

	llm := ExpensiveLLM answers: #('continue' nil) toolsToExecute: #('Smalltalk/evaluate' '').
	agent := self configuredUsing: (ExpensiveLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assertEvaluated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello' 'continue'))! !


!CodingAgentTest methodsFor: 'agents' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
configuredUsing: aLLM

	^self configuredWith: self initialMoney using: aLLM! !

!CodingAgentTest methodsFor: 'agents' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
configuredWith: aMoney using: aLLM

	^CodingAgent
		availableMoney: aMoney
		servers: (Array with: self smalltalkServer)
		llm: aLLM! !

!CodingAgentTest methodsFor: 'agents' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
configuredWithBothServersUsing: aLLM

	^CodingAgent
		availableMoney: self initialMoney
		servers: (Array with: self smalltalkServer with: self fileSystemServer)
		llm: aLLM! !


!CodingAgentTest methodsFor: 'costs' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
costOfPrompting: aPrompt withContext: aContext tools: aToolNames

	^(llm costOfPrompt: aPrompt)
		+ (llm costOfContext: aContext)
		+ (llm costOfTools: aToolNames)! !

!CodingAgentTest methodsFor: 'costs' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
costOfPrompts: aPrompts

	^self costOfPrompts: aPrompts tools: self smalltalkToolNames! !

!CodingAgentTest methodsFor: 'costs' stamp: 'HAW 24/Nov/2026, 11:31:54 pm (UTC)'!
costOfPrompts: aPrompts tools: aToolNames

	| context total |

	context := ''.
	total := 0*dollar.
	aPrompts do: [ :aPrompt |
		total := total
			+ (self costOfPrompting: aPrompt withContext: context tools: aToolNames).
		context := context, aPrompt ].

	^total! !


!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
assert: aMoney isCloseTo: anExpectedMoney

	self assert: (aMoney - anExpectedMoney) abs < (0.001*dollar)! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assert: anAgent spent: aCost

	self assert: anAgent spent: aCost from: self initialMoney! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assert: anAgent spent: aCost from: anInitialMoney

	self assert: anAgent availableMoney isCloseTo: anInitialMoney - aCost! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assertCreated: aFiles

	self assert: createdFiles asArray equals: aFiles! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assertEvaluated: anAnswers

	self assert: evaluatedAnswers asArray equals: anAnswers! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assertNoToolWasExecuted

	self assert: evaluatedAnswers isEmpty.
	self assert: createdFiles isEmpty! !


!CodingAgentTest methodsFor: 'money' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
initialMoney

	^10*dollar! !


!CodingAgentTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
createFileTool

	^Tool named: 'createFile' doing: [ :anAnswer | createdFiles add: anAnswer ]! !

!CodingAgentTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
evaluateTool

	^Tool named: 'evaluate' doing: [ :anAnswer | evaluatedAnswers add: anAnswer ]! !

!CodingAgentTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
smalltalkToolNames

	^'Smalltalk/evaluate'! !


!classDefinition: #ModelContextProtocolServerTest category: #'2026-2C-2doParcial'!
TestCase subclass: #ModelContextProtocolServerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
test01ServerNameCannotBeEmpty

	self
		should: [
			ModelContextProtocolServer
				named: ''
				tools: (Array with: self evaluateTool) ]
		raise: Error
		withMessageText: ModelContextProtocolServer nameCannotBeEmptyErrorDescription! !

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
test02ServerMustHaveTools

	self
		should: [ ModelContextProtocolServer named: 'Smalltalk' tools: #() ]
		raise: Error
		withMessageText: ModelContextProtocolServer toolsCannotBeEmptyErrorDescription! !

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:32:13 pm (UTC)'!
test03ToolNamesMustBeUniqueInServer

	self
		should: [
			ModelContextProtocolServer
				named: 'Smalltalk'
				tools: self toolsNamedAlike ]
		raise: Error
		withMessageText: ModelContextProtocolServer repeatedToolNameErrorDescription! !


!ModelContextProtocolServerTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
evaluateTool

	^Tool named: 'evaluate' doing: [ :anAnswer | ]! !

!ModelContextProtocolServerTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
toolsNamedAlike

	^Array with: self evaluateTool with: self evaluateTool! !


!classDefinition: #ToolTest category: #'2026-2C-2doParcial'!
TestCase subclass: #ToolTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ToolTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
test01ToolNameCannotBeEmpty

	self
		should: [ Tool named: '' doing: [ :anAnswer | ] ]
		raise: Error
		withMessageText: Tool nameCannotBeEmptyErrorDescription! !

!ToolTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:22:12 pm (UTC)'!
test02ToolExecutesItsActionWithAnswer

	| executedAnswer tool |

	tool := Tool named: 'evaluate' doing: [ :anAnswer | executedAnswer := anAnswer ].

	tool executeWith: 'continue'.

	self assert: executedAnswer equals: 'continue'! !

```
