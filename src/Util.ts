export async function readFile(url : string) : Promise<string> {
    return await fetch(url).then((res) => res.text());
}

export type UniformI<T, A extends unknown[]> = {
    value : T,
    set: (...args : A) => void
}
export function uniformOf<T, A extends unknown[]>(setter : (...args : A) => T, type? : string) {
    return {
        value: null as T,
        set(...args : A) {
            this.value = setter(...args);
        },
        type
    };
}
